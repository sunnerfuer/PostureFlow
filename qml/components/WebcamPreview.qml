import QtQuick
import QtMultimedia
import "../theme" as Style

Rectangle {
    id: root

    property string postureKey: "good"
    property bool skeletonVisible: true
    property bool live: true
    property bool framingGuide: false
    property bool mirrored: false
    property string cameraError: ""

    signal skeletonToggled(bool checked)

    readonly property bool cameraAvailable: devices.videoInputs.length > 0

    radius: 18
    color: "#1C1C26"
    clip: true

    function updateCamera() {
        if (root.visible && root.live && root.cameraAvailable) {
            root.cameraError = ""
            webcamCamera.start()
        } else {
            webcamCamera.stop()
        }
    }

    MediaDevices {
        id: devices
        onVideoInputsChanged: root.updateCamera()
    }

    CaptureSession {
        id: captureSession
        camera: Camera {
            id: webcamCamera
            cameraDevice: devices.defaultVideoInput

            onErrorOccurred: function(error, errorString) {
                root.cameraError = errorString
            }
        }
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectFit

        transform: Scale {
            origin.x: videoOutput.width / 2
            xScale: root.mirrored ? -1 : 1
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#1C1C26"
        visible: !webcamCamera.active || root.cameraError !== ""

        Column {
            width: parent.width - 48
            anchors.centerIn: parent
            spacing: 10

            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                font.family: Style.Theme.fontFamily
                font.pixelSize: 17
                color: "white"
                text: root.cameraError !== ""
                      ? "Ошибка камеры: " + root.cameraError
                      : (!root.cameraAvailable
                         ? "Веб-камера не обнаружена"
                         : (!root.live
                            ? "Камера выключена или сеанс на паузе"
                            : "Подключение к веб-камере..."))
            }

            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.family: Style.Theme.fontFamily
                font.pixelSize: 12
                color: "#B9B8C2"
                text: "Предпросмотр без записи видео"
            }
        }
    }

    Canvas {
        anchors.fill: parent
        visible: root.framingGuide && webcamCamera.active

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.strokeStyle = "#C9B6F4"
            ctx.lineWidth = 3
            ctx.lineCap = "round"
            var x = width * 0.20
            var y = height * 0.24
            var w = width * 0.60
            var h = height * 0.61
            var l = 34
            function line(x1, y1, x2, y2) {
                ctx.beginPath()
                ctx.moveTo(x1, y1)
                ctx.lineTo(x2, y2)
                ctx.stroke()
            }
            line(x, y, x + l, y)
            line(x, y, x, y + l)
            line(x + w, y, x + w - l, y)
            line(x + w, y, x + w, y + l)
            line(x, y + h, x + l, y + h)
            line(x, y + h, x, y + h - l)
            line(x + w, y + h, x + w - l, y + h)
            line(x + w, y + h, x + w, y + h - l)
        }
    }

    Rectangle {
        visible: root.live && webcamCamera.active && !root.framingGuide
        x: 12
        y: 12
        width: 68
        height: 32
        radius: 10
        color: "#292825DD"

        Row {
            anchors.centerIn: parent
            spacing: 7
            Rectangle {
                width: 8
                height: 8
                radius: 4
                color: Style.Theme.lime
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: "ЭФИР"
                color: "white"
                font.family: Style.Theme.fontFamily
                font.pixelSize: 12
                font.weight: Font.Bold
            }
        }
    }

    Rectangle {
        visible: webcamCamera.active && !root.framingGuide
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 12
        width: 165
        height: 32
        radius: 10
        color: "#292825DD"

        Text {
            anchors.centerIn: parent
            text: "Скелет: после ML"
            color: "white"
            font.family: Style.Theme.fontFamily
            font.pixelSize: 11
        }
    }

    Rectangle {
        visible: webcamCamera.active && !root.framingGuide
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 34
        color: "#25231F99"

        Row {
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            spacing: 8

            Text {
                text: root.cameraAvailable ? devices.defaultVideoInput.description : "Камера"
                color: "white"
                elide: Text.ElideRight
                width: parent.width - 105
                font.family: Style.Theme.fontFamily
                font.pixelSize: 11
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "Локально"
                color: "white"
                font.family: Style.Theme.fontFamily
                font.pixelSize: 11
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    onLiveChanged: updateCamera()
    onVisibleChanged: updateCamera()
    Component.onCompleted: updateCamera()
    Component.onDestruction: webcamCamera.stop()
}
