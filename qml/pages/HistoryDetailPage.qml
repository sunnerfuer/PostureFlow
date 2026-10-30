import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Flickable {
    id: root
    clip:true
    contentWidth:width
    contentHeight:Math.max(height,content.implicitHeight+Style.Theme.pagePadding*2)

    ColumnLayout {
        id:content
        x:Style.Theme.pagePadding;y:18
        width:root.width-Style.Theme.pagePadding*2
        spacing:16

        Item {
            Layout.fillWidth:true;Layout.preferredHeight:120
            Column{anchors.left:parent.left;spacing:6
                Text{text:"←  Назад к истории";color:"#536089";font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold
                    MouseArea{anchors.fill:parent;cursorShape:Qt.PointingHandCursor;onClicked:appState.backToHistory()}
                }
                Item{width:1;height:5}
                Text{text:"Сеанс — "+appState.selectedSession.date;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:32;font.weight:Font.Bold}
                Text{text:appState.selectedSession.time+" – "+appState.selectedSession.end;color:"#667092";font.family:Style.Theme.fontFamily;font.pixelSize:16}
            }
            Row{anchors.right:parent.right;anchors.top:parent.top;spacing:16
                Rectangle{width:38;height:38;radius:19;color:"white";border.color:Style.Theme.border;Text{anchors.centerIn:parent;text:"♧";font.pixelSize:20}}
                Rectangle{width:42;height:42;radius:21;clip:true;Image{anchors.fill:parent;source:"../../assets/avatar.png";fillMode:Image.PreserveAspectCrop}}
            }
        }

        RowLayout{
            Layout.fillWidth:true;Layout.preferredHeight:125;spacing:16
            MetricCard{Layout.fillWidth:true;Layout.fillHeight:true;title:"Качество осанки";value:appState.selectedSession.quality+"%";accent:Style.Theme.lilac;softColor:"#F5F1FF";iconText:"▥"}
            MetricCard{Layout.fillWidth:true;Layout.fillHeight:true;title:"Длительность";value:appState.selectedSession.duration;accent:Style.Theme.good;softColor:"#F3FBEB";iconText:"◷"}
            MetricCard{Layout.fillWidth:true;Layout.fillHeight:true;title:"Предупреждения";value:appState.selectedSession.alerts;accent:Style.Theme.peach;softColor:"#FFF3ED";iconText:"△"}
        }

        AppCard{
            Layout.fillWidth:true;Layout.preferredHeight:235
            Column{anchors.fill:parent;anchors.margins:18;spacing:8
                Row{width:parent.width;Text{text:"Хронология сеанса";width:parent.width-150;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:18;font.weight:Font.Bold}Text{text:appState.selectedSession.time+" – "+appState.selectedSession.end;color:"#667092";font.family:Style.Theme.fontFamily;font.pixelSize:13}}
                SessionTimeline{width:parent.width;height:150;compact:true;endLabel:appState.selectedSession.end}
                Row{anchors.horizontalCenter:parent.horizontalCenter;spacing:26
                    Repeater{model:[{k:"good",t:"Хорошая осанка"},{k:"forward",t:"Наклон вперёд"},{k:"left",t:"Наклон влево"}];delegate:Row{spacing:7;Rectangle{width:11;height:11;radius:6;color:Style.Theme.postureColor(modelData.k);anchors.verticalCenter:parent.verticalCenter}Text{text:modelData.t;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}}
                }
            }
        }

        RowLayout{
            Layout.fillWidth:true;Layout.preferredHeight:235;spacing:16
            AppCard{
                Layout.fillWidth:true;Layout.preferredWidth:340;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:18;spacing:10
                    Text{text:"Распределение поз";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold}
                    DistributionBar{width:parent.width;height:48;label:"Хорошая осанка";value:appState.selectedSession.good;accent:Style.Theme.good}
                    DistributionBar{width:parent.width;height:48;label:"Наклон вперёд";value:appState.selectedSession.forward;accent:Style.Theme.forward}
                    DistributionBar{width:parent.width;height:48;label:"Наклон влево";value:appState.selectedSession.left;accent:Style.Theme.left}
                }
            }
            AppCard{
                Layout.fillWidth:true;Layout.preferredWidth:350;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:18;spacing:10
                    Text{text:"Ключевые события";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold}
                    Repeater{model:[{time:"15:42",k:"forward",t:"Наклон вперёд",d:"Исправлено через 18 с"},{time:"15:24",k:"left",t:"Наклон влево",d:"Исправлено через 9 с"},{time:appState.selectedSession.time,k:"good",t:"Сеанс начат",d:"Мониторинг осанки начат"}]
                        delegate:Row{width:parent.width;height:48;spacing:10
                            Rectangle{width:10;height:10;radius:5;color:Style.Theme.postureColor(modelData.k);anchors.top:parent.top;anchors.topMargin:5}
                            Text{text:modelData.time;color:"#667092";font.family:Style.Theme.fontFamily;font.pixelSize:11;width:52}
                            Column{spacing:3;Text{text:modelData.t;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:11;font.weight:Font.DemiBold}Text{text:modelData.d;color:"#7A819D";font.family:Style.Theme.fontFamily;font.pixelSize:10}}
                        }
                    }
                }
            }
            AppCard{
                Layout.fillWidth:true;Layout.preferredWidth:340;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:18;spacing:12
                    Row{spacing:10;Rectangle{width:38;height:38;radius:19;color:Style.Theme.lilacSoft;Text{anchors.centerIn:parent;text:"▤";font.pixelSize:19}}Text{text:"Итоги сеанса";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold;anchors.verticalCenter:parent.verticalCenter}}
                    Rectangle{width:parent.width;height:128;radius:14;color:"#FAFAFB";border.color:Style.Theme.border
                        Text{anchors.fill:parent;anchors.margins:16;text:"Основная проблема: "+appState.selectedSession.issue+".\n\nВ целом качество осанки было хорошим: потребовалось лишь несколько коротких корректировок.";wrapMode:Text.WordWrap;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;lineHeight:1.25}
                    }
                }
            }
        }
    }
}
