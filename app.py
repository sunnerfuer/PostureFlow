import os
import sys
from pathlib import Path

from PySide6.QtCore import QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from backend import AppState, BackendBridge


def main() -> int:
    app = QGuiApplication(sys.argv)
    app.setApplicationName("PostureFlow")
    app.setOrganizationName("PostureFlow")

    root = Path(__file__).resolve().parent
    qml_file = root / "qml" / "main.qml"

    state = AppState()
    bridge = BackendBridge(state)
    app._postureflow_bridge = bridge  # keep the future backend adapter alive
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("appState", state)
    engine.addImportPath(str(root / "qml"))
    engine.load(QUrl.fromLocalFile(str(qml_file)))

    if not engine.rootObjects():
        return 1
    return app.exec()


if __name__ == "__main__":
    raise SystemExit(main())
