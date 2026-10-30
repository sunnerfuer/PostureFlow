import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    anchors.fill:parent
    property bool stable: true
    property bool advancedOpen: false
    ColumnLayout {
        anchors.fill:parent;anchors.margins:28;spacing:12
        Column{spacing:4;Text{text:"Распознавание";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:30;font.weight:Font.Bold}Text{text:"Настройте параметры распознавания позы во время мониторинга.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14}}
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:98
            Column{anchors.fill:parent;anchors.margins:16;spacing:6
                Text{text:"Чувствительность распознавания позы";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}
                Slider{id:sensitivity;width:parent.width;height:28;from:0;to:100;value:70
                    background:Rectangle{x:sensitivity.leftPadding;y:sensitivity.topPadding+sensitivity.availableHeight/2-height/2;width:sensitivity.availableWidth;height:6;radius:3;color:"#E9E5F2";Rectangle{width:sensitivity.visualPosition*parent.width;height:parent.height;radius:3;color:"#A783F2"}}
                    handle:Rectangle{x:sensitivity.leftPadding+sensitivity.visualPosition*(sensitivity.availableWidth-width);y:sensitivity.topPadding+sensitivity.availableHeight/2-height/2;width:20;height:20;radius:10;color:"#9C77F0";border.color:"white";border.width:3}
                }
                Row{width:parent.width;Text{text:"Низкая";width:parent.width/2;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:10}Text{text:"Высокая";width:parent.width/2;horizontalAlignment:Text.AlignRight;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:10}}
            }
        }
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:72
            Row{anchors.fill:parent;anchors.margins:16
                Column{width:parent.width-70;spacing:3;Text{text:"Стабильное распознавание";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}Text{text:"Игнорировать очень краткие изменения позы.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                ToggleSwitch{checked:stable;anchors.verticalCenter:parent.verticalCenter;onToggled:stable=checked}
            }
        }
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:64
            Row{anchors.fill:parent;anchors.margins:14
                Text{text:"Минимальная длительность распознавания";width:parent.width-230;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold;anchors.verticalCenter:parent.verticalCenter}
                AppSelect{width:210;height:42;model:["1 секунда","3 секунды","5 секунд"];currentIndex:1;anchors.verticalCenter:parent.verticalCenter}
            }
        }
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:advancedOpen?130:56
            Column{anchors.fill:parent
                Rectangle{width:parent.width;height:56;color:"transparent"
                    Text{anchors.left:parent.left;anchors.leftMargin:16;anchors.verticalCenter:parent.verticalCenter;text:"Расширенные настройки";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}
                    Text{anchors.right:parent.right;anchors.rightMargin:16;anchors.verticalCenter:parent.verticalCenter;text:advancedOpen?"⌃":"⌄";font.pixelSize:18;color:Style.Theme.textPrimary}
                    MouseArea{anchors.fill:parent;cursorShape:Qt.PointingHandCursor;onClicked:advancedOpen=!advancedOpen}
                }
                Text{visible:advancedOpen;width:parent.width-32;x:16;text:"Версия модели: демонстрационный UI-мост\nПорог уверенности и сглаживание будут подключены через Python-бэкенд.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11;lineHeight:1.3}
            }
        }
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:150
            Row{anchors.fill:parent;anchors.margins:18;spacing:14
                Rectangle{width:64;height:64;radius:32;color:Style.Theme.lilacSoft;Text{anchors.centerIn:parent;text:"♙";font.pixelSize:28;color:"#33275C"}}
                Column{width:parent.width-300;spacing:4;anchors.verticalCenter:parent.verticalCenter
                    Text{text:"Персональная калибровка";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:16;font.weight:Font.Bold}
                    Text{width:parent.width;text:"Настройте PostureFlow под вашу нейтральную позу сидя.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}
                    Rectangle{width:parent.width;height:52;radius:12;color:Style.Theme.goodSoft
                        Row{anchors.fill:parent;anchors.margins:12;spacing:10;Rectangle{width:20;height:20;radius:10;color:"#80BB3A";Text{anchors.centerIn:parent;text:"✓";color:"white";font.pixelSize:13}}Column{spacing:2;Text{text:"Статус: откалибровано";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:11;font.weight:Font.DemiBold}Text{text:"Последняя калибровка: "+appState.lastCalibration;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:10}}}
                    }
                }
                AppButton{width:195;text:"Повторить калибровку";baseColor:Style.Theme.lime;hoverColor:"#E1F69A";textColor:Style.Theme.textPrimary;anchors.verticalCenter:parent.verticalCenter;onClicked:appState.startCalibration()}
            }
        }
        AppCard{Layout.fillWidth:true;Layout.preferredHeight:72;cardColor:Style.Theme.lilacSoft;strokeColor:"#E0D7F6";Text{anchors.fill:parent;anchors.margins:16;text:"ⓘ   Калибровка помогает PostureFlow запомнить вашу нейтральную позу и точнее определять её изменения во время работы.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11;verticalAlignment:Text.AlignVCenter}}
        Item{Layout.fillHeight:true}
    }
}
