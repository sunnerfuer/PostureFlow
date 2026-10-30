import QtQuick
import "../theme" as Style

Column {
    id: root
    property string selected: "camera"
    signal choose(string key)
    spacing: 4

    Repeater {
        model: [
            {key:"camera", icon:"▣", label:"Камера"},
            {key:"notifications", icon:"♧", label:"Уведомления"},
            {key:"detection", icon:"☷", label:"Распознавание"},
            {key:"appearance", icon:"◉", label:"Оформление"},
            {key:"profile", icon:"♙", label:"Профиль"}
        ]
        delegate: Rectangle {
            width: root.width
            height: 52
            radius: 13
            color: root.selected === modelData.key ? Style.Theme.lilacSoft : (ma.containsMouse ? "#F7F5FA" : "transparent")
            Row {
                anchors.fill:parent;anchors.leftMargin:16;spacing:15
                Text { text:modelData.icon;color:Style.Theme.textPrimary;font.pixelSize:20;anchors.verticalCenter:parent.verticalCenter;width:24;horizontalAlignment:Text.AlignHCenter }
                Text { text:modelData.label;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:root.selected===modelData.key?Font.DemiBold:Font.Normal;anchors.verticalCenter:parent.verticalCenter }
            }
            MouseArea { id:ma;anchors.fill:parent;hoverEnabled:true;cursorShape:Qt.PointingHandCursor;onClicked:root.choose(modelData.key) }
        }
    }
}
