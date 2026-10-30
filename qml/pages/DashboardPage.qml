import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    id: root
    property real uiScale: Math.min(1.0, height / 900.0)
    clip: true

    ColumnLayout {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.leftMargin: Style.Theme.pagePadding
        anchors.rightMargin: Style.Theme.pagePadding
        anchors.topMargin: 14
        anchors.bottomMargin: 14

        spacing: Math.round(16 * root.uiScale)

        PageHeader {
            Layout.fillWidth: true
            title: "Главная"
            subtitle: "Краткая сводка по вашей осанке за сегодня."
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Math.round(16 * root.uiScale)
            Layout.preferredHeight: Math.round(250 * root.uiScale)

            AppCard {
                Layout.fillWidth: true
                Layout.preferredWidth: 430
                Layout.fillHeight: true
                cardColor: Style.Theme.lilacSoft
                strokeColor: "#DED2F7"
                Column {
                    anchors.fill: parent; anchors.margins: 20; spacing: 5
                    Text { text:"ОСАНКА СЕГОДНЯ"; color:"#443A76"; font.family:Style.Theme.fontFamily; font.pixelSize:11; font.weight:Font.Bold; font.letterSpacing:1.1 }
                    Text { text:appState.dashboardSummary.score+"%"; color:Style.Theme.textPrimary; font.family:Style.Theme.fontFamily; font.pixelSize:50; font.weight:Font.Bold }
                    Text { text:"В целом хорошо"; color:Style.Theme.textPrimary; font.family:Style.Theme.fontFamily; font.pixelSize:16; font.weight:Font.DemiBold }
                    Text { text:"↑  6% со вчерашнего дня"; color:"#4FA51E"; font.family:Style.Theme.fontFamily; font.pixelSize:13; font.weight:Font.DemiBold }
                    Canvas {
                        width: parent.width; height: Math.round(54 * root.uiScale)
                        onPaint: {
                            var c=getContext("2d");c.clearRect(0,0,width,height);c.strokeStyle="#8C67EA";c.lineWidth=2.2
                            var v=[31,29,35,31,29,34,32,36,40,37,43,49,47,55,60,62]
                            c.beginPath(); for(var i=0;i<v.length;i++){var x=i*width/(v.length-1),y=height-(v[i]-20)*1.2;if(i===0)c.moveTo(x,y);else c.lineTo(x,y)} c.stroke()
                            c.beginPath();c.arc(width-2,height-(v[v.length-1]-20)*1.2,4,0,Math.PI*2);c.fillStyle="#7651D8";c.fill()
                        }
                    }
                    Text { text:"Сегодня вы дольше сохраняете нейтральную позу."; color:Style.Theme.textSecondary; font.family:Style.Theme.fontFamily; font.pixelSize:12 }
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 305
                spacing: Math.round(14 * root.uiScale)
                AppCard {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    cardColor: Style.Theme.goodSoft; strokeColor: "#DDEDC2"
                    Row {
                        anchors.fill: parent; anchors.margins: 18; spacing: 12
                        Column { width: parent.width-95; spacing:5
                            Text { text:"ХОРОШАЯ ОСАНКА"; color:"#455261"; font.family:Style.Theme.fontFamily; font.pixelSize:10; font.weight:Font.Bold; font.letterSpacing:1 }
                            Text { text:appState.dashboardSummary.goodTime; color:Style.Theme.textPrimary; font.family:Style.Theme.fontFamily; font.pixelSize:32; font.weight:Font.Bold }
                            Text { text:appState.dashboardSummary.goodPercent+"% времени мониторинга"; color:Style.Theme.textSecondary; font.family:Style.Theme.fontFamily; font.pixelSize:12 }
                        }
                        CircularProgress { width:Math.round(74 * root.uiScale);height:Math.round(74 * root.uiScale);value:.76;accent:"#70B623";track:"#DAEABF";strokeWidth:8; anchors.verticalCenter:parent.verticalCenter
                            Text { anchors.centerIn:parent;text:"76%";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:16;font.weight:Font.Bold }
                        }
                    }
                }
                AppCard {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    cardColor: Style.Theme.forwardSoft; strokeColor:"#F2CDBE"
                    Row {
                        anchors.fill:parent; anchors.margins:18
                        Column { width:parent.width-70; spacing:4
                            Text { text:"КОРРЕКТИРОВКИ"; color:"#5D4B4B"; font.family:Style.Theme.fontFamily; font.pixelSize:10; font.weight:Font.Bold; font.letterSpacing:1 }
                            Text { text:appState.dashboardSummary.corrections; color:Style.Theme.textPrimary; font.family:Style.Theme.fontFamily; font.pixelSize:34; font.weight:Font.Bold }
                            Text { text:"↓  На 4 меньше, чем вчера"; color:"#398F27"; font.family:Style.Theme.fontFamily; font.pixelSize:12 }
                        }
                        Rectangle { width:48;height:48;radius:24;color:"#F7C6B3";anchors.verticalCenter:parent.verticalCenter
                            Text { anchors.centerIn:parent;text:"✎";font.pixelSize:22;color:Style.Theme.textPrimary }
                        }
                    }
                }
            }

            AppCard {
                Layout.fillWidth: true
                Layout.preferredWidth: 290
                Layout.fillHeight: true
                cardColor: Style.Theme.sidebar
                strokeColor: Style.Theme.sidebar
                Column {
                    anchors.fill: parent; anchors.margins: 20; spacing: 9
                    Text { text:"ТЕКУЩИЙ СЕАНС"; color:"#DAD9E1"; font.family:Style.Theme.fontFamily; font.pixelSize:10; font.weight:Font.Bold; font.letterSpacing:1.2 }
                    Text { text:"42 мин"; color:"white"; font.family:Style.Theme.fontFamily; font.pixelSize:36; font.weight:Font.Bold }
                    Row { spacing:8; Rectangle{width:11;height:11;radius:6;color:Style.Theme.good;anchors.verticalCenter:parent.verticalCenter} Text{text:"Хорошая осанка";color:"#E6E5EA";font.family:Style.Theme.fontFamily;font.pixelSize:14} }
                    AppButton { width:parent.width;height:42;text:"Открыть  →";baseColor:"white";hoverColor:"#F3F2F4";textColor:Style.Theme.textPrimary;onClicked:appState.navigate("live") }
                    Text { width:parent.width;text:"Начните или продолжите мониторинг,\nчтобы отслеживать осанку в реальном времени.";color:"#B7B6C0";font.family:Style.Theme.fontFamily;font.pixelSize:11;lineHeight:1.3 }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(255 * root.uiScale)
            spacing: Math.round(16 * root.uiScale)
            AppCard {
                Layout.fillWidth: true; Layout.preferredWidth: 760; Layout.fillHeight: true
                Column {
                    anchors.fill:parent; anchors.margins:18; spacing:2
                    Row { width:parent.width
                        Column { width:parent.width-110; spacing:3
                            Text{text:"Динамика осанки";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:18;font.weight:Font.Bold}
                            Text{text:"Качество осанки за последние 7 дней";color:"#667092";font.family:Style.Theme.fontFamily;font.pixelSize:12}
                        }
                        AppSelect { width:95; model:["Неделя","Месяц"]; currentIndex:0 }
                    }
                    LineChart { width:parent.width;height:Math.round(175 * root.uiScale);values:appState.weeklyQuality;labels:appState.weeklyLabels }
                }
            }
            AppCard {
                Layout.fillWidth: true; Layout.preferredWidth: 320; Layout.fillHeight:true
                Column { anchors.fill:parent;anchors.margins:18;spacing:9
                    Text{text:"Фокус на сегодня";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:18;font.weight:Font.Bold}
                    Row { spacing:12
                        Rectangle{width:54;height:54;radius:14;color:Style.Theme.lilacSoft;Text{anchors.centerIn:parent;text:"◎";font.pixelSize:26;color:"#34275E"}}
                        Column{spacing:3;Text{text:appState.dashboardSummary.focus;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold;color:Style.Theme.textPrimary}Text{text:appState.dashboardSummary.focusMinutes+" мин всего";font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold;color:Style.Theme.textPrimary}Text{text:"↓ 12% по сравнению со вчера";font.family:Style.Theme.fontFamily;font.pixelSize:11;color:"#4C9C28"}}
                    }
                    Text{width:parent.width;text:"Сегодня вы меньше наклоняетесь вперёд. Так держать!";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:12}
                    Text{text:"Подробнее  →";color:"#6D48DF";font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(175 * root.uiScale)
            spacing: Math.round(16 * root.uiScale)
            AppCard {
                Layout.fillWidth:true;Layout.preferredWidth:590;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:18;spacing:8
                    Text{text:"Осанка сегодня";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:18;font.weight:Font.Bold}
                    Repeater { model: appState.postureDistribution
                        delegate: DistributionBar { width:parent.width; height:Math.round(34 * root.uiScale); label:modelData.label; value:modelData.value; accent:Style.Theme.postureColor(modelData.key) }
                    }
                }
            }
            AppCard {
                Layout.fillWidth:true;Layout.preferredWidth:490;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:18;spacing:7
                    Row{width:parent.width;Text{text:"Последние события осанки";width:parent.width-60;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:18;font.weight:Font.Bold}Text{text:"Все";color:"#6D48DF";font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                    Repeater { model: 3
                        delegate: Row { property var ev: appState.recentEvents[index]; width:parent.width;height:Math.round(27 * root.uiScale);spacing:10
                            Rectangle{width:10;height:10;radius:5;color:Style.Theme.postureColor(parent.ev.key);anchors.verticalCenter:parent.verticalCenter}
                            Text{text:parent.ev.time;color:"#657095";font.family:Style.Theme.fontFamily;font.pixelSize:11;width:48}
                            Text{text:parent.ev.label;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11;width:135}
                            Text{text:parent.ev.detail.length?"—  Исправлено через "+parent.ev.detail:"";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}
                        }
                    }
                    Text{text:"История сеансов  →";color:"#6D48DF";font.family:Style.Theme.fontFamily;font.pixelSize:11;font.weight:Font.DemiBold;MouseArea{anchors.fill:parent;cursorShape:Qt.PointingHandCursor;onClicked:appState.navigate("history")}}
                }
            }
        }
    }
}
