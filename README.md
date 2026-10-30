# PostureFlow frontend

Desktop frontend implementation of the approved PostureFlow diploma UI.

## Stack

- Python 3.10+
- PySide6
- Qt Quick / QML

The project is frontend-only. `backend/app_state.py` is the integration boundary for the future MediaPipe / ML pipeline.

## Run

```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
# macOS/Linux
# source .venv/bin/activate

pip install -r requirements.txt
python app.py
```

The UI targets **1440 × 900** and has a minimum window width of **1280 px**.

## Demo controls

On **Live Monitoring**:

- `1` → Good posture
- `2` → Leaning forward
- `3` → Leaning left
- `Space` → Pause / Resume

The buttons also implement the approved `Start → Pause/Resume → End` monitoring states.

## Backend integration boundary

Replace mock values by publishing application-level results through `BackendBridge` / `AppState`. The visual QML components only depend on UI-facing properties such as:

- `postureKey`, `confidence`
- `monitoringState`, `elapsedText`
- `goodMinutes`, `correctionCount`
- `recentEvents`, `historySessions`
- calibration state/progress

No QML component imports MediaPipe or model code.

## Design

The implementation follows the supplied approved specification and latest mockups: warm cream canvas, charcoal sidebar, pastel semantic posture colors, rounded cards, calm SaaS hierarchy, and the approved navigation/settings/calibration structure.

**Font:** QML requests `Manrope`; if it is not installed, Qt falls back to the system sans-serif font. No font files are bundled.
