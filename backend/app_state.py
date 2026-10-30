from __future__ import annotations

from datetime import datetime
from PySide6.QtCore import QObject, Property, Signal, Slot, QTimer

from .mock_data import (
    DASHBOARD_SUMMARY, STATISTICS_SUMMARY, WEEKLY_QUALITY, WEEKLY_LABELS, CORRECTIONS_BY_DAY,
    POSTURE_DISTRIBUTION, RECENT_EVENTS_BY_STATE, HISTORY_SESSIONS,
)


class AppState(QObject):
    """UI-facing state boundary.

    Real MediaPipe / ML code can later push posture classes, confidence,
    correction events and calibration results into this object without any
    visual component importing or knowing about the model implementation.
    """

    currentPageChanged = Signal()
    postureChanged = Signal()
    monitoringChanged = Signal()
    sessionChanged = Signal()
    skeletonChanged = Signal()
    recentEventsChanged = Signal()
    selectedSessionChanged = Signal()
    settingsCategoryChanged = Signal()
    calibrationChanged = Signal()

    def __init__(self) -> None:
        super().__init__()
        self._current_page = "dashboard"
        self._posture_key = "good"
        self._confidence = 92
        self._monitoring_state = "active"  # not_started | active | paused
        self._elapsed_seconds = 42 * 60 + 16
        self._good_minutes = 31
        self._correction_count = 6
        self._skeleton_visible = True
        self._settings_category = "camera"
        self._selected_session = dict(HISTORY_SESSIONS[0])
        self._calibration_active = False
        self._calibration_step = 1
        self._calibration_countdown = 3
        self._calibration_progress = 0.0
        self._calibrated = True
        self._last_calibration = "10 сентября 2026"

        self._session_timer = QTimer(self)
        self._session_timer.setInterval(1000)
        self._session_timer.timeout.connect(self._tick_session)
        self._session_timer.start()

        self._calibration_timer = QTimer(self)
        self._calibration_timer.setInterval(1000)
        self._calibration_timer.timeout.connect(self._tick_calibration)

    # ---------- navigation ----------
    @Property(str, notify=currentPageChanged)
    def currentPage(self):
        return self._current_page

    @Slot(str)
    def navigate(self, page: str):
        if page == self._current_page:
            return
        self._current_page = page
        self.currentPageChanged.emit()

    # ---------- posture / monitoring ----------
    @Property(str, notify=postureChanged)
    def postureKey(self):
        return self._posture_key

    @Property(str, notify=postureChanged)
    def postureLabel(self):
        return {
            "good": "ХОРОШАЯ ОСАНКА",
            "forward": "НАКЛОН ВПЕРЁД",
            "left": "НАКЛОН ВЛЕВО",
        }[self._posture_key]

    @Property(str, notify=postureChanged)
    def postureMessage(self):
        return {
            "good": "Положение выглядит сбалансированным.",
            "forward": "Слегка отведите корпус назад.",
            "left": "Верните плечи ближе к центру.",
        }[self._posture_key]

    @Property(str, notify=postureChanged)
    def postureTip(self):
        return {
            "good": "Вы сидите хорошо. Расслабьте плечи и продолжайте работать в обычном режиме.",
            "forward": "Слегка отведите корпус назад и расслабьте шею. Расположите плечи над тазом.",
            "left": "Мягко верните плечи к центру. Держите корпус ровно и не наклоняйтесь в сторону.",
        }[self._posture_key]

    @Property(int, notify=postureChanged)
    def confidence(self):
        return self._confidence

    @Slot(str, float)
    def applyBackendPosture(self, key: str, confidence: float):
        if key not in ("good", "forward", "left"):
            return
        self._posture_key = key
        self._confidence = max(0, min(100, int(round(confidence))))
        self.postureChanged.emit()
        self.recentEventsChanged.emit()

    @Slot(str)
    def applyBackendMonitoringState(self, state: str):
        if state not in ("not_started", "active", "paused"):
            return
        self._monitoring_state = state
        self.monitoringChanged.emit()

    @Slot(bool, str)
    def applyBackendCalibration(self, ok: bool, display_date: str):
        self._calibrated = bool(ok)
        if ok and display_date:
            self._last_calibration = display_date
        self.calibrationChanged.emit()

    @Slot(str)
    def setPostureState(self, key: str):
        if key not in ("good", "forward", "left"):
            return
        self._posture_key = key
        if key == "good":
            self._confidence, self._good_minutes, self._correction_count = 92, 31, 6
        elif key == "forward":
            self._confidence, self._good_minutes, self._correction_count = 89, 29, 7
        else:
            self._confidence, self._good_minutes, self._correction_count = 91, 30, 7
        self.postureChanged.emit()
        self.recentEventsChanged.emit()
        self.sessionChanged.emit()

    @Property(str, notify=monitoringChanged)
    def monitoringState(self):
        return self._monitoring_state

    @Property(bool, notify=monitoringChanged)
    def monitoringActive(self):
        return self._monitoring_state == "active"

    @Slot()
    def startMonitoring(self):
        self._monitoring_state = "active"
        self.monitoringChanged.emit()

    @Slot()
    def pauseMonitoring(self):
        if self._monitoring_state == "active":
            self._monitoring_state = "paused"
            self.monitoringChanged.emit()

    @Slot()
    def resumeMonitoring(self):
        if self._monitoring_state == "paused":
            self._monitoring_state = "active"
            self.monitoringChanged.emit()

    @Slot()
    def endMonitoring(self):
        self._monitoring_state = "not_started"
        self._elapsed_seconds = 0
        self.monitoringChanged.emit()
        self.sessionChanged.emit()

    @Property(str, notify=sessionChanged)
    def elapsedText(self):
        h = self._elapsed_seconds // 3600
        m = (self._elapsed_seconds % 3600) // 60
        s = self._elapsed_seconds % 60
        return f"{h:02d}:{m:02d}:{s:02d}"

    @Property(int, notify=sessionChanged)
    def goodMinutes(self):
        return self._good_minutes

    @Property(int, notify=sessionChanged)
    def correctionCount(self):
        return self._correction_count

    def _tick_session(self):
        if self._monitoring_state == "active":
            self._elapsed_seconds += 1
            self.sessionChanged.emit()

    @Property(bool, notify=skeletonChanged)
    def skeletonVisible(self):
        return self._skeleton_visible

    @Slot(bool)
    def setSkeletonVisible(self, value: bool):
        if value != self._skeleton_visible:
            self._skeleton_visible = value
            self.skeletonChanged.emit()

    # ---------- mock analytics ----------
    @Property("QVariantMap", constant=True)
    def dashboardSummary(self):
        return DASHBOARD_SUMMARY

    @Property("QVariantMap", constant=True)
    def statisticsSummary(self):
        return STATISTICS_SUMMARY

    @Property("QVariantList", constant=True)
    def weeklyQuality(self):
        return WEEKLY_QUALITY

    @Property("QVariantList", constant=True)
    def weeklyLabels(self):
        return WEEKLY_LABELS

    @Property("QVariantList", constant=True)
    def correctionsByDay(self):
        return CORRECTIONS_BY_DAY

    @Property("QVariantList", constant=True)
    def postureDistribution(self):
        return POSTURE_DISTRIBUTION

    @Property("QVariantList", notify=recentEventsChanged)
    def recentEvents(self):
        return RECENT_EVENTS_BY_STATE[self._posture_key]

    @Property("QVariantList", constant=True)
    def historySessions(self):
        return HISTORY_SESSIONS

    # ---------- history ----------
    @Property("QVariantMap", notify=selectedSessionChanged)
    def selectedSession(self):
        return self._selected_session

    @Slot(int)
    def openSession(self, index: int):
        if 0 <= index < len(HISTORY_SESSIONS):
            self._selected_session = dict(HISTORY_SESSIONS[index])
            self.selectedSessionChanged.emit()
            self.navigate("historyDetail")

    @Slot()
    def backToHistory(self):
        self.navigate("history")

    # ---------- settings ----------
    @Property(str, notify=settingsCategoryChanged)
    def settingsCategory(self):
        return self._settings_category

    @Slot(str)
    def setSettingsCategory(self, category: str):
        if category in ("camera", "notifications", "detection", "appearance", "profile"):
            self._settings_category = category
            self._calibration_active = False
            self.settingsCategoryChanged.emit()
            self.calibrationChanged.emit()

    # ---------- calibration ----------
    @Property(bool, notify=calibrationChanged)
    def calibrationActive(self):
        return self._calibration_active

    @Property(int, notify=calibrationChanged)
    def calibrationStep(self):
        return self._calibration_step

    @Property(int, notify=calibrationChanged)
    def calibrationCountdown(self):
        return self._calibration_countdown

    @Property(float, notify=calibrationChanged)
    def calibrationProgress(self):
        return self._calibration_progress

    @Property(bool, notify=calibrationChanged)
    def calibrated(self):
        return self._calibrated

    @Property(str, notify=calibrationChanged)
    def lastCalibration(self):
        return self._last_calibration

    @Slot()
    def startCalibration(self):
        self._settings_category = "detection"
        self._calibration_active = True
        self._calibration_step = 1
        self._calibration_countdown = 3
        self._calibration_progress = 0.0
        self.settingsCategoryChanged.emit()
        self.calibrationChanged.emit()

    @Slot()
    def nextCalibration(self):
        if not self._calibration_active:
            return
        if self._calibration_step == 1:
            self._calibration_step = 2
        elif self._calibration_step == 2:
            self._calibration_step = 3
            self._calibration_countdown = 3
            self._calibration_progress = 0.0
            self._calibration_timer.start()
        self.calibrationChanged.emit()

    @Slot()
    def previousCalibration(self):
        if self._calibration_step > 1 and self._calibration_step < 4:
            self._calibration_timer.stop()
            self._calibration_step -= 1
            self._calibration_countdown = 3
            self._calibration_progress = 0.0
            self.calibrationChanged.emit()

    @Slot()
    def cancelCalibration(self):
        self._calibration_timer.stop()
        self._calibration_active = False
        self._calibration_step = 1
        self.calibrationChanged.emit()

    @Slot()
    def finishCalibration(self):
        self._calibration_active = False
        self._calibration_step = 1
        self._settings_category = "detection"
        self.settingsCategoryChanged.emit()
        self.calibrationChanged.emit()

    @Slot()
    def finishCalibrationAndMonitor(self):
        self.finishCalibration()
        self.startMonitoring()
        self.navigate("live")

    def _tick_calibration(self):
        if self._calibration_step != 3:
            self._calibration_timer.stop()
            return
        self._calibration_countdown -= 1
        self._calibration_progress = min(1.0, (3 - self._calibration_countdown) / 3.0)
        if self._calibration_countdown <= 0:
            self._calibration_timer.stop()
            self._calibration_step = 4
            self._calibration_countdown = 0
            self._calibration_progress = 1.0
            self._calibrated = True
            self._last_calibration = "10 сентября 2026"
        self.calibrationChanged.emit()
