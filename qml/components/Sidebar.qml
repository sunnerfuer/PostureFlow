import QtQuick
import QtQuick.Layouts
import "../theme" as Style

Rectangle {
    id: root
    signal navigate(string page)
    width: Style.Theme.sidebarWidth
    color: Style.Theme.sidebar

    function pageActive(key) {
        if (key === "history" && appState.currentPage === "historyDetail") return true
        return appState.currentPage === key
    }

    Column {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 10

        Row {
            width: parent.width
            height: 62
            spacing: 10
            Image {
                source: "../../assets/main_icon_cat.png"
                width: 48; height: 48
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: "PostureFlow"
                color: "white"
                font.family: Style.Theme.fontFamily
                font.pixelSize: 20
                font.weight: Font.Bold
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Repeater {
            model: [
                {key:"dashboard", icon:"home", label:"Главная"},
                {key:"live", icon:"camera", label:"Мониторинг"},
                {key:"statistics", icon:"statistics", label:"Статистика"},
                {key:"history", icon:"history", label:"История"},
                {key:"settings", icon:"settings", label:"Настройки"}
            ]
            delegate: Rectangle {
                width: parent.width
                height: 48
                radius: 15
                color: root.pageActive(modelData.key) ? Style.Theme.lime : (mouse.containsMouse ? "#24242E" : "transparent")
                Behavior on color { ColorAnimation { duration: 100 } }
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 14
                    spacing: 14
                    Image {
                        width: 32
                        height: 32

                        anchors.verticalCenter: parent.verticalCenter

                        source: root.pageActive(modelData.key)
                                ? "../../assets/icons/" + modelData.icon + "_dark.png"
                                : "../../assets/icons/" + modelData.icon + "_white.png"

                        fillMode: Image.PreserveAspectFit
                        smooth: true
                        mipmap: true
                    }
                    Text {
                        text: modelData.label
                        color: root.pageActive(modelData.key) ? Style.Theme.textPrimary : "#D9D8DF"
                        font.family: Style.Theme.fontFamily
                        font.pixelSize: 14
                        font.weight: root.pageActive(modelData.key) ? Font.DemiBold : Font.Normal
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.navigate(modelData.key)
                }
            }
        }

        Item { width: 1; height: Math.max(40, root.height - 62 - 5*58 - 205) }

        Rectangle {
            width: parent.width
            height: 82
            radius: 16
            color: Style.Theme.sidebarSoft
            border.color: "#FFFFFF0C"
            Row {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10
                Rectangle {
                    width: 10; height: 10; radius: 5
                    color: Style.Theme.lime
                    anchors.top: parent.top; anchors.topMargin: 4
                }
                Column {
                    width: parent.width - 48
                    spacing: 4
                    Text { text: appState.monitoringActive ? "Мониторинг активен" : "Камера готова"; color:"white"; font.family:Style.Theme.fontFamily; font.pixelSize:11; font.weight:Font.DemiBold }
                    Text { text: appState.monitoringActive ? "Веб-камера\nподключена" : "Готово к мониторингу"; color:"#B9B8C1"; font.family:Style.Theme.fontFamily; font.pixelSize:10; lineHeight:1.25 }
                }
                Text { text:"▣"; color:"white"; font.pixelSize:16; anchors.verticalCenter: parent.verticalCenter }
            }
        }

        Rectangle { width: parent.width; height: 1; color: "#FFFFFF0E" }

        Row {
            width: parent.width; height: 54; spacing: 10
            Rectangle {
                width: 38; height: 38; radius: 19; clip: true; color: "#30303A"; anchors.verticalCenter: parent.verticalCenter
                Image { anchors.fill: parent; source:"../../assets/avatar.png"; fillMode: Image.PreserveAspectCrop }
            }
            Text { text:"Мария"; color:"white"; font.family:Style.Theme.fontFamily; font.pixelSize:14; anchors.verticalCenter: parent.verticalCenter; width: parent.width-68 }
            Text { text:"›"; color:"#DDDBE4"; font.pixelSize:24; anchors.verticalCenter: parent.verticalCenter }
        }
    }
}
