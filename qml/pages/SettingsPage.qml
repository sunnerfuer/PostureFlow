import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Flickable {
    id: root
    clip:true
    contentWidth:width
    contentHeight:Math.max(height,content.implicitHeight+20)

    ColumnLayout {
        id:content
        x:Style.Theme.pagePadding;y:14
        width:root.width-Style.Theme.pagePadding*2
        spacing:14

        PageHeader{Layout.fillWidth:true;title:"Настройки";subtitle:"Настройте PostureFlow под себя."}

        RowLayout {
            Layout.fillWidth:true
            Layout.preferredHeight: root.height - 112
            spacing:18

            ColumnLayout {
                Layout.preferredWidth:260
                Layout.fillHeight:true
                spacing:14
                AppCard {
                    Layout.fillWidth:true
                    Layout.preferredHeight:320
                    SettingsNav {
                        anchors.fill:parent;anchors.margins:14
                        selected: appState.settingsCategory
                        onChoose: appState.setSettingsCategory(key)
                    }
                }
                Rectangle {
                    Layout.fillWidth:true
                    Layout.preferredHeight:170
                    radius:18;clip:true;color:Style.Theme.lilacSoft
                    Image{anchors.fill:parent;source:"../../assets/settings_deco.png";fillMode:Image.PreserveAspectFit}
                }
                AppCard {
                    Layout.fillWidth:true
                    Layout.preferredHeight:125
                    Text{anchors.fill:parent;anchors.margins:18;text:"«Здоровая осанка сегодня —\nбольше энергии завтра.»   ✦";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;lineHeight:1.3}
                }
                Item{Layout.fillHeight:true}
            }

            AppCard {
                Layout.fillWidth:true
                Layout.fillHeight:true
                cardRadius:22
                Loader {
                    id: settingsLoader
                    anchors.fill:parent
                    anchors.margins: 0
                    source: appState.calibrationActive ? "../settings/CalibrationFlow.qml" : (
                        appState.settingsCategory === "notifications" ? "../settings/NotificationsSettings.qml" :
                        appState.settingsCategory === "detection" ? "../settings/DetectionSettings.qml" :
                        appState.settingsCategory === "appearance" ? "../settings/AppearanceSettings.qml" :
                        appState.settingsCategory === "profile" ? "../settings/ProfileSettings.qml" :
                        "../settings/CameraSettings.qml")
                }
            }
        }
    }
}
