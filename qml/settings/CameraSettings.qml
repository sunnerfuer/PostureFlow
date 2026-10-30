import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    id: root
    anchors.fill: parent
    property bool mirrorCamera: true
    ColumnLayout {
        anchors.fill:parent;anchors.margins:28;spacing:18
        RowLayout {
            Layout.fillWidth:true;Layout.preferredHeight:62
            Column{Layout.fillWidth:true;spacing:4
                Text{text:"Камера";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:30;font.weight:Font.Bold}
                Text{text:"Выберите камеру для мониторинга осанки.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14}
            }
            Rectangle{Layout.preferredWidth:150;Layout.preferredHeight:42;radius:21;color:Style.Theme.goodSoft;Row{anchors.centerIn:parent;spacing:8;Text{text:"▣";font.pixelSize:16}Text{text:"Камера готова";font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}}}
        }

        RowLayout {
            Layout.fillWidth:true;Layout.fillHeight:true;spacing:22
            ColumnLayout {
                Layout.fillWidth:true;Layout.preferredWidth:520;Layout.fillHeight:true;spacing:10
                Text{text:"Камера";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}
                AppSelect{Layout.fillWidth:true;Layout.preferredHeight:48;model:["Встроенная веб-камера (1080p)","Внешняя USB-камера"];currentIndex:0}
                Item{height:4;width:1}
                Text{text:"Предпросмотр камеры";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}
                WebcamPreview{Layout.fillWidth:true;Layout.fillHeight:true;Layout.maximumHeight:360;postureKey:"good";skeletonVisible:appState.skeletonVisible;mirrored:root.mirrorCamera;live:false;onSkeletonToggled:appState.setSkeletonVisible(checked)}
            }
            ColumnLayout {
                Layout.preferredWidth:390;Layout.fillHeight:true;spacing:16
                AppCard {
                    Layout.fillWidth:true;Layout.preferredHeight:230;cardColor:"#FBFAF8"
                    Column{anchors.fill:parent;anchors.margins:20;spacing:20
                        Text{text:"Настройки камеры";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:15;font.weight:Font.Bold}
                        Row{width:parent.width;height:62;spacing:14
                            Rectangle{width:44;height:44;radius:22;color:"white";Text{anchors.centerIn:parent;text:"⇆";font.pixelSize:20}}
                            Column{width:parent.width-110;spacing:3;Text{text:"Зеркальное изображение";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}Text{text:"Отображать изображение зеркально";color:Style.Theme.textMuted;font.family:Style.Theme.fontFamily;font.pixelSize:10}}
                            ToggleSwitch{checked:root.mirrorCamera;anchors.verticalCenter:parent.verticalCenter;onToggled:root.mirrorCamera=checked}
                        }
                        Row{width:parent.width;height:70;spacing:14
                            Rectangle{width:44;height:44;radius:22;color:"white";Text{anchors.centerIn:parent;text:"⌘";font.pixelSize:19}}
                            Column{width:parent.width-110;spacing:3;Text{text:"Показывать скелет позы";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}Text{width:parent.width;text:"Показывать ключевые точки и линии позы\nв окне камеры";color:Style.Theme.textMuted;font.family:Style.Theme.fontFamily;font.pixelSize:10}}
                            ToggleSwitch{checked:appState.skeletonVisible;anchors.verticalCenter:parent.verticalCenter;onToggled:appState.setSkeletonVisible(checked)}
                        }
                    }
                }
                AppCard {
                    Layout.fillWidth:true;Layout.preferredHeight:110;cardColor:Style.Theme.lilacSoft;strokeColor:"#E0D7F6"
                    Row{anchors.fill:parent;anchors.margins:18;spacing:14
                        Rectangle{width:42;height:42;radius:21;color:"#DACEFA";Text{anchors.centerIn:parent;text:"ⓘ";font.pixelSize:19;color:"#3E3471"}}
                        Column{width:parent.width-60;spacing:4;Text{text:"Хорошее освещение помогает";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}Text{width:parent.width;text:"Для лучшего результата убедитесь, что верхняя часть тела и плечи хорошо видны.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11;lineHeight:1.2}}
                    }
                }
                Item{Layout.fillHeight:true}
            }
        }
    }
}
