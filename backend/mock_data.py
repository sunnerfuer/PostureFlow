"""Mock/demo data used by the PostureFlow frontend.

This file is deliberately backend-only.  Replace these structures with real
session/statistics repositories later; QML should continue to consume the same
AppState properties.
"""


DASHBOARD_SUMMARY = {
    "score": 84,
    "goodTime": "3 ч 42 мин",
    "goodPercent": 76,
    "corrections": 11,
    "focus": "Наклон вперёд",
    "focusMinutes": 38,
}

STATISTICS_SUMMARY = {
    "quality": 82,
    "goodTime": "6 ч 14 мин",
    "goodPercent": 76,
    "corrections": 24,
    "commonIssue": "Наклон вперёд",
    "commonIssueTime": "1 ч 24 мин",
    "consistencyDays": 5,
}

WEEKLY_QUALITY = [70, 72, 61, 60, 69, 75, 82]
WEEKLY_LABELS = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
CORRECTIONS_BY_DAY = [4, 6, 3, 2, 4, 3, 2]

POSTURE_DISTRIBUTION = [
    {"key": "good", "label": "Хорошая осанка", "value": 76},
    {"key": "forward", "label": "Наклон вперёд", "value": 17},
    {"key": "left", "label": "Наклон влево", "value": 7},
]

RECENT_EVENTS = [
    {"time": "20:22", "key": "forward", "label": "Наклон вперёд", "detail": "14 с"},
    {"time": "20:08", "key": "left", "label": "Наклон влево", "detail": "8 с"},
    {"time": "19:55", "key": "forward", "label": "Наклон вперёд", "detail": "21 с"},
    {"time": "19:48", "key": "good", "label": "Сеанс начат", "detail": ""},
]

RECENT_EVENTS_BY_STATE = {
    "good": RECENT_EVENTS,
    "forward": [
        {"time": "20:24", "key": "forward", "label": "Наклон вперёд", "detail": "18 с"},
        {"time": "20:22", "key": "forward", "label": "Наклон вперёд", "detail": "14 с"},
        {"time": "20:08", "key": "left", "label": "Наклон влево", "detail": "8 с"},
        {"time": "19:48", "key": "good", "label": "Сеанс начат", "detail": ""},
    ],
    "left": [
        {"time": "20:26", "key": "left", "label": "Наклон влево", "detail": "10 с"},
        {"time": "20:08", "key": "left", "label": "Наклон влево", "detail": "8 с"},
        {"time": "19:55", "key": "forward", "label": "Наклон вперёд", "detail": "21 с"},
        {"time": "19:48", "key": "good", "label": "Сеанс начат", "detail": ""},
    ],
}

HISTORY_SESSIONS = [
    {
        "date": "10 сентября 2024", "time": "14:20", "duration": "1 ч 45 мин",
        "quality": 86, "issueKey": "forward", "issue": "Наклон вперёд",
        "alerts": 8, "end": "16:05", "good": 81, "forward": 14, "left": 5,
    },
    {
        "date": "9 сентября 2024", "time": "18:10", "duration": "52 мин",
        "quality": 78, "issueKey": "left", "issue": "Наклон влево",
        "alerts": 7, "end": "19:02", "good": 72, "forward": 12, "left": 16,
    },
    {
        "date": "8 сентября 2024", "time": "09:30", "duration": "2 ч 05 мин",
        "quality": 88, "issueKey": "forward", "issue": "Наклон вперёд",
        "alerts": 6, "end": "11:35", "good": 84, "forward": 11, "left": 5,
    },
    {
        "date": "7 сентября 2024", "time": "13:15", "duration": "1 ч 12 мин",
        "quality": 81, "issueKey": "good", "issue": "Хорошая осанка",
        "alerts": 5, "end": "14:27", "good": 83, "forward": 10, "left": 7,
    },
    {
        "date": "6 сентября 2024", "time": "20:05", "duration": "47 мин",
        "quality": 74, "issueKey": "left", "issue": "Наклон влево",
        "alerts": 9, "end": "20:52", "good": 69, "forward": 12, "left": 19,
    },
]
