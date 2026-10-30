import QtQuick
import "../theme" as Style

AppCard {
    id: root
    property string postureKey: "good"
    property string postureLabel: "ХОРОШАЯ ОСАНКА"
    property string message: "Положение выглядит сбалансированным."
    property int confidence: 92
    property color accent: Style.Theme.postureColor(postureKey)
    cardColor: Style.Theme.postureSoftColor(postureKey)
    strokeColor: Qt.rgba(accent.r, accent.g, accent.b, 0.32)

    Column {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 9
        Text {
            text: "ТЕКУЩАЯ ПОЗА"
            color: "#64647A"
            font.family: Style.Theme.fontFamily; font.pixelSize: 10; font.weight: Font.Bold; font.letterSpacing: 1.0
        }
        Row {
            spacing: 10
            Rectangle { width: 18; height: 18; radius: 9; color: root.accent; anchors.verticalCenter: parent.verticalCenter }
            Text {
                text: root.postureLabel
                color: Style.Theme.textPrimary
                font.family: Style.Theme.fontFamily; font.pixelSize: 22; font.weight: Font.Bold
            }
        }
        Text {
            text: root.message
            width: parent.width
            color: Style.Theme.textSecondary
            font.family: Style.Theme.fontFamily; font.pixelSize: 12
            wrapMode: Text.WordWrap
        }
        Rectangle {
            width: parent.width; height: 7; radius: 4; color: "#FFFFFF66"
            Rectangle { height: parent.height; radius: parent.radius; width: parent.width * root.confidence / 100; color: root.accent }
        }
        Row {
            width: parent.width
            Text { text: "Поза определена"; color: Style.Theme.textSecondary; font.family: Style.Theme.fontFamily; font.pixelSize: 12; width: parent.width - 48 }
            Text { text: root.confidence + "%"; color: Style.Theme.textPrimary; font.family: Style.Theme.fontFamily; font.pixelSize: 13; font.weight: Font.Bold }
        }
    }
}
