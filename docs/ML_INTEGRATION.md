# ML integration boundary

The QML layer is intentionally unaware of MediaPipe or the posture classifier.

`backend/app_state.py` is the UI-facing state boundary. The future inference worker should publish normalized application-level values only, for example:

- posture class: `good`, `forward`, or `left`
- confidence: `0..100`
- monitoring/session state
- correction event timestamp + duration
- calibration completion/result

The existing demo slot `setPostureState()` can be replaced or complemented by a backend-fed update method without changing the QML components.

Do not send raw landmarks, tensors, feature vectors, or MediaPipe objects to QML.
