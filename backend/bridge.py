from __future__ import annotations

from PySide6.QtCore import QObject, Slot

from .app_state import AppState


class BackendBridge(QObject):
    """Backend-facing adapter for the future posture pipeline.

    MediaPipe / classifier code should call this adapter with application-level
    results rather than touching QML objects directly.
    """

    def __init__(self, state: AppState) -> None:
        super().__init__()
        self._state = state

    @Slot(str, float)
    def push_posture(self, posture_key: str, confidence: float) -> None:
        self._state.applyBackendPosture(posture_key, confidence)

    @Slot(str)
    def push_monitoring_state(self, state: str) -> None:
        self._state.applyBackendMonitoringState(state)

    @Slot(bool, str)
    def push_calibration_result(self, ok: bool, display_date: str) -> None:
        self._state.applyBackendCalibration(ok, display_date)
