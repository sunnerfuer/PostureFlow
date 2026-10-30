import QtQuick
import "../theme" as Style

Item {
    id: root
    property bool compact: false
    property string postureKey: "good"
    property string endLabel: compact ? "16:05" : "20:30"
    property var markers: compact ? [
        {p:.14,key:"left"},{p:.33,key:"forward"},{p:.49,key:"left"},{p:.63,key:"forward"},{p:.78,key:"forward"},{p:.88,key:"left"}
    ] : (postureKey === "forward" ? [
        {p:.07,key:"good"},{p:.10,key:"good"},{p:.15,key:"forward"},{p:.23,key:"left"},{p:.34,key:"good"},{p:.46,key:"left"},{p:.58,key:"good"},{p:.70,key:"forward"},{p:.78,key:"forward"},{p:.86,key:"forward"},{p:.92,key:"good"}
    ] : (postureKey === "left" ? [
        {p:.07,key:"good"},{p:.10,key:"good"},{p:.15,key:"forward"},{p:.23,key:"left"},{p:.34,key:"good"},{p:.46,key:"left"},{p:.58,key:"good"},{p:.70,key:"forward"},{p:.78,key:"good"},{p:.86,key:"left"},{p:.92,key:"left"}
    ] : [
        {p:.07,key:"good"},{p:.10,key:"good"},{p:.15,key:"forward"},{p:.23,key:"left"},{p:.34,key:"good"},{p:.46,key:"left"},{p:.58,key:"good"},{p:.70,key:"forward"},{p:.78,key:"good"},{p:.86,key:"forward"},{p:.92,key:"good"}
    ]))

    Rectangle {
        id: track
        x: 6; y: compact ? 40 : 52
        width: root.width - 12
        height: compact ? 18 : 10
        radius: height/2
        color: compact ? Style.Theme.good : "#F1F1F2"
    }
    Repeater {
        model: root.markers
        delegate: Rectangle {
            width: compact ? 26 : 4
            height: compact ? track.height : 18
            radius: compact ? 0 : 2
            x: track.x + track.width * modelData.p - width/2
            y: compact ? track.y : track.y - 4
            color: Style.Theme.postureColor(modelData.key)
        }
    }
    Text { text: compact ? "14:20" : "19:48"; x:0; y:track.y+track.height+10; color:"#69708D"; font.family:Style.Theme.fontFamily; font.pixelSize:10 }
    Text { text: root.endLabel; anchors.right:parent.right; y:track.y+track.height+10; color:"#69708D"; font.family:Style.Theme.fontFamily; font.pixelSize:10 }

    Row {
        visible: !root.compact
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 24
        Repeater {
            model:[{k:"good",t:"Хорошая осанка"},{k:"forward",t:"Наклон вперёд"},{k:"left",t:"Наклон влево"}]
            delegate: Row {
                spacing:6
                Rectangle { width:10;height:10;radius:5;color:Style.Theme.postureColor(modelData.k);anchors.verticalCenter:parent.verticalCenter }
                Text { text:modelData.t;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:10 }
            }
        }
    }
}
