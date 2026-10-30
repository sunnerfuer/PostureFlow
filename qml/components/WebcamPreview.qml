import QtQuick
import "../theme" as Style

Rectangle {
    id: root
    property string postureKey: "good"
    property bool skeletonVisible: true
    property bool live: true
    property bool framingGuide: false
    property bool mirrored: false
    signal skeletonToggled(bool checked)
    radius: 18
    color: "#D8D2CA"
    clip: true

    function sourceForPosture() {
        if (postureKey === "forward") return "../../assets/camera_forward.jpg"
        if (postureKey === "left") return "../../assets/camera_left.jpg"
        return "../../assets/camera_good.jpg"
    }

    Image {
        anchors.fill: parent
        source: root.sourceForPosture()
        fillMode: Image.PreserveAspectCrop
        mirror: root.mirrored
        smooth: true
    }

    Canvas {
        id: skeleton
        anchors.fill: parent
        visible: root.skeletonVisible && !root.framingGuide
        opacity: 0.78
        onPaint: {
            var ctx=getContext("2d");ctx.clearRect(0,0,width,height)
            var c = root.postureKey === "forward" ? "#F1AE91" : (root.postureKey === "left" ? "#C9B6F4" : "#CFEA7A")
            var pts
            if(root.postureKey === "forward") pts=[[0.39,0.57],[0.50,0.62],[0.61,0.58],[0.33,0.91],[0.67,0.91]]
            else if(root.postureKey === "left") pts=[[0.39,0.54],[0.51,0.60],[0.63,0.64],[0.34,0.91],[0.70,0.91]]
            else pts=[[0.37,0.56],[0.50,0.56],[0.63,0.56],[0.31,0.91],[0.69,0.91]]
            function P(i){return [pts[i][0]*width,pts[i][1]*height]}
            ctx.strokeStyle="rgba(255,255,255,0.80)";ctx.lineWidth=2;ctx.lineCap="round"
            ctx.beginPath();var p=P(0);ctx.moveTo(p[0],p[1]);p=P(1);ctx.lineTo(p[0],p[1]);p=P(2);ctx.lineTo(p[0],p[1]);ctx.stroke()
            ctx.beginPath();p=P(1);ctx.moveTo(p[0],p[1]);ctx.lineTo(p[0],height*0.90);ctx.stroke()
            ctx.beginPath();p=P(0);ctx.moveTo(p[0],p[1]);p=P(3);ctx.lineTo(p[0],p[1]);ctx.stroke()
            ctx.beginPath();p=P(2);ctx.moveTo(p[0],p[1]);p=P(4);ctx.lineTo(p[0],p[1]);ctx.stroke()
            for(var i=0;i<3;i++){p=P(i);ctx.beginPath();ctx.arc(p[0],p[1],8,0,Math.PI*2);ctx.fillStyle=c;ctx.fill();ctx.strokeStyle="rgba(255,255,255,.7)";ctx.lineWidth=1;ctx.stroke()}
        }
        onWidthChanged: requestPaint(); onHeightChanged: requestPaint()
    }
    onPostureKeyChanged: skeleton.requestPaint()
    onSkeletonVisibleChanged: skeleton.requestPaint()

    Canvas {
        anchors.fill: parent
        visible: root.framingGuide
        onPaint: {
            var ctx=getContext("2d");ctx.clearRect(0,0,width,height)
            ctx.strokeStyle="#C9B6F4";ctx.lineWidth=3;ctx.lineCap="round"
            var x=width*.20,y=height*.24,w=width*.60,h=height*.61,l=34
            function seg(x1,y1,x2,y2){ctx.beginPath();ctx.moveTo(x1,y1);ctx.lineTo(x2,y2);ctx.stroke()}
            seg(x,y,x+l,y);seg(x,y,x,y+l);seg(x+w,y,x+w-l,y);seg(x+w,y,x+w,y+l)
            seg(x,y+h,x+l,y+h);seg(x,y+h,x,y+h-l);seg(x+w,y+h,x+w-l,y+h);seg(x+w,y+h,x+w,y+h-l)
        }
    }

    Rectangle {
        visible: root.live && !root.framingGuide
        x: 12; y: 12; width: 68; height: 32; radius: 10
        color: "#292825DD"
        Row { anchors.centerIn: parent; spacing: 7
            Rectangle { width: 8; height: 8; radius: 4; color: Style.Theme.lime; anchors.verticalCenter: parent.verticalCenter }
            Text { text: "ЭФИР"; color: "white"; font.family: Style.Theme.fontFamily; font.pixelSize: 12; font.weight: Font.Bold }
        }
    }
    Rectangle {
        visible: !root.framingGuide
        anchors.right: parent.right; anchors.top: parent.top; anchors.margins: 12
        width: 110; height: 32; radius: 10; color: "#292825DD"
        Row { anchors.centerIn: parent; spacing: 8
            Text { text: "Скелет позы"; color: "white"; font.family: Style.Theme.fontFamily; font.pixelSize: 11 }
            Rectangle { width: 34; height: 18; radius: 9; color: root.skeletonVisible ? "#6B9230" : "#65656D"
                Rectangle { width:14;height:14;radius:7;y:2;x:root.skeletonVisible?18:2;color:"white"; Behavior on x { NumberAnimation { duration:120 } } }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.skeletonToggled(!root.skeletonVisible) }
            }
        }
    }
    Rectangle {
        visible: !root.framingGuide
        anchors.left: parent.left; anchors.right: parent.right; anchors.bottom: parent.bottom
        height: 34; color: "#25231F99"
        Row {
            anchors.fill: parent; anchors.leftMargin: 14; anchors.rightMargin: 14
            Text { text: "▣  Встроенная веб-камера"; color: "white"; font.family: Style.Theme.fontFamily; font.pixelSize: 11; anchors.verticalCenter: parent.verticalCenter; width: parent.width-70 }
            Text { text: "30 кадр/с"; color: "white"; font.family: Style.Theme.fontFamily; font.pixelSize: 11; anchors.verticalCenter: parent.verticalCenter }
        }
    }
    Rectangle {
        visible: root.framingGuide
        anchors.right: parent.right; anchors.top: parent.top; anchors.margins: 12
        width: 108; height: 32; radius: 10; color: "#292825DD"
        Row { anchors.centerIn: parent; spacing: 7
            Text { text: "Вы в кадре"; color: "white"; font.family: Style.Theme.fontFamily; font.pixelSize: 10 }
            Rectangle { width:9;height:9;radius:5;color:Style.Theme.lime; anchors.verticalCenter: parent.verticalCenter }
        }
    }
}
