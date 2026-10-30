import QtQuick
import "../theme" as Style

Item {
    id: root
    property string title: "Главная"
    property string subtitle: ""
    implicitHeight: 70

    Column {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 3
        Text { text: root.title; color:Style.Theme.textPrimary; font.family:Style.Theme.fontFamily; font.pixelSize:Style.Theme.pageTitle; font.weight:Font.Bold }
        Text { text:root.subtitle; visible:subtitle.length>0; color:"#657095"; font.family:Style.Theme.fontFamily; font.pixelSize:14 }
    }
    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16
        Rectangle {
            width: 38; height:38; radius:19; color:"white"; border.color:Style.Theme.border
            Text { anchors.centerIn:parent; text:"♧"; color:Style.Theme.textPrimary; font.pixelSize:20 }
            Rectangle { width:6;height:6;radius:3;color:"#FF6B74";anchors.right:parent.right;anchors.top:parent.top;anchors.margins:5 }
        }
        Rectangle {
            width: 42; height:42; radius:21; clip:true; color:"#E9E6E0"
            Image { anchors.fill: parent; source:"../../assets/avatar.png"; fillMode:Image.PreserveAspectCrop }
        }
    }
}
