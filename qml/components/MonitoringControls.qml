import QtQuick
import QtQuick.Layouts
import "../theme" as Style

RowLayout {
    id: root
    property string monitoringState: "active"
    signal startRequested()
    signal pauseRequested()
    signal resumeRequested()
    signal endRequested()
    spacing: 12

    Rectangle {
        Layout.preferredWidth: 150
        Layout.preferredHeight: 46
        radius: 22
        color: root.monitoringState === "active" ? Style.Theme.goodSoft : (root.monitoringState === "paused" ? Style.Theme.lilacSoft : "#F1F0ED")
        Row {
            anchors.centerIn: parent
            spacing: 8
            Rectangle { width: 12; height: 12; radius: 6; color: root.monitoringState === "active" ? "#7DB733" : (root.monitoringState === "paused" ? Style.Theme.lilac : "#B5B3BA") }
            Text { text: root.monitoringState === "active" ? "Мониторинг" : (root.monitoringState === "paused" ? "Пауза" : "Готово"); color: Style.Theme.textPrimary; font.family: Style.Theme.fontFamily; font.pixelSize: 13; font.weight: Font.DemiBold }
        }
    }
    Item { Layout.fillWidth: true }
    AppButton {
        visible: root.monitoringState === "not_started"
        Layout.preferredWidth: 220
        text: "●  Начать мониторинг"
        baseColor: Style.Theme.lime
        hoverColor: "#E2F59F"
        textColor: Style.Theme.textPrimary
        onClicked: root.startRequested()
    }
    AppButton {
        visible: root.monitoringState !== "not_started"
        Layout.preferredWidth: 190
        text: root.monitoringState === "paused" ? "▶  Продолжить" : "Ⅱ  Пауза"
        baseColor: "white"
        hoverColor: "#F8F7F5"
        textColor: Style.Theme.textPrimary
        borderColor: "#BCBDC7"
        onClicked: root.monitoringState === "paused" ? root.resumeRequested() : root.pauseRequested()
    }
    AppButton {
        visible: root.monitoringState !== "not_started"
        Layout.preferredWidth: 220
        text: "■  Завершить сеанс"
        baseColor: Style.Theme.peachSoft
        hoverColor: "#F9D8CA"
        textColor: Style.Theme.textPrimary
        onClicked: root.endRequested()
    }
}
