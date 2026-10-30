import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    id:root
    anchors.fill:parent
    readonly property int step: appState.calibrationStep

    ColumnLayout {
        anchors.fill:parent;anchors.margins:28;spacing:14

        Column{spacing:4
            Text{text:"Персональная калибровка";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:30;font.weight:Font.Bold}
            Text{text:"Настройте PostureFlow под вашу нейтральную позу сидя.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14}
        }

        RowLayout {
            Layout.fillWidth:true;Layout.preferredHeight:54;spacing:8
            Repeater {
                model:["Проверка камеры","Нейтральная поза","Не двигайтесь","Готово"]
                delegate: RowLayout {
                    Layout.fillWidth:true;spacing:7
                    Rectangle {
                        width:34;height:34;radius:17
                        color: index+1 < root.step ? Style.Theme.lime : (index+1===root.step ? Style.Theme.lilacSoft : "#F1F0F2")
                        border.color: index+1===root.step ? Style.Theme.lilac : "transparent"
                        Text{anchors.centerIn:parent;text:index+1<root.step?"✓":String(index+1);color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}
                    }
                    Text{text:modelData;color:index+1<=root.step?Style.Theme.textPrimary:Style.Theme.textMuted;font.family:Style.Theme.fontFamily;font.pixelSize:11;font.weight:index+1===root.step?Font.DemiBold:Font.Normal}
                    Rectangle{visible:index<3;Layout.fillWidth:true;height:2;color:index+1<root.step?Style.Theme.lime:Style.Theme.border}
                }
            }
        }

        RowLayout {
            Layout.fillWidth:true;Layout.fillHeight:true;spacing:22

            WebcamPreview {
                Layout.fillWidth:true;Layout.preferredWidth:540;Layout.fillHeight:true;Layout.maximumHeight:470
                postureKey:"good"
                skeletonVisible:false
                live:false
                framingGuide: root.step >= 1 && root.step <= 3
            }

            ColumnLayout {
                Layout.preferredWidth:390;Layout.fillHeight:true;spacing:14
                Item{Layout.fillHeight:true;visible:root.step===4}
                Text {
                    visible:root.step===1
                    text:"Проверка камеры"
                    color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:28;font.weight:Font.Bold
                }
                Text {
                    visible:root.step===1
                    Layout.fillWidth:true
                    text:"Убедитесь, что верхняя часть тела и плечи хорошо видны."
                    wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14;lineHeight:1.3
                }
                AppCard {
                    visible:root.step===1
                    Layout.fillWidth:true;Layout.preferredHeight:78;cardColor:Style.Theme.goodSoft;strokeColor:"#DDEDC2"
                    Text{anchors.fill:parent;anchors.margins:16;text:"✓  Вы в кадре. Можно продолжать.";verticalAlignment:Text.AlignVCenter;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}
                }

                Text { visible:root.step===2;text:"Нейтральная поза";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:28;font.weight:Font.Bold }
                Text { visible:root.step===2;Layout.fillWidth:true;text:"Сядьте в удобную нейтральную позу. Не нужно специально выпрямляться слишком сильно.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14;lineHeight:1.3 }
                AppCard{visible:root.step===2;Layout.fillWidth:true;Layout.preferredHeight:84;cardColor:Style.Theme.lilacSoft;strokeColor:"#E0D7F6";Text{anchors.fill:parent;anchors.margins:16;text:"Расслабьте плечи и смотрите в сторону камеры. PostureFlow сохранит эту позу как вашу персональную базовую.";wrapMode:Text.WordWrap;verticalAlignment:Text.AlignVCenter;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}

                Text{visible:root.step===3;text:"Не двигайтесь";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:28;font.weight:Font.Bold}
                Text{visible:root.step===3;Layout.fillWidth:true;text:"Сядьте в удобную нейтральную позу.\nНе двигайтесь, пока мы сохраняем базовое положение.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14;lineHeight:1.4}
                Item{visible:root.step===3;Layout.alignment:Qt.AlignHCenter;Layout.preferredWidth:150;Layout.preferredHeight:150
                    CircularProgress{anchors.fill:parent;value:appState.calibrationProgress;accent:"#A67DF2";track:"#E7DCF9";strokeWidth:10}
                    Column{anchors.centerIn:parent;spacing:0;Text{text:appState.calibrationCountdown;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:34;font.weight:Font.Bold;anchors.horizontalCenter:parent.horizontalCenter}Text{text:"секунд\nосталось";horizontalAlignment:Text.AlignHCenter;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                }
                Text{visible:root.step===3;Layout.fillWidth:true;text:"Сохраняем вашу персональную нейтральную позу.";horizontalAlignment:Text.AlignHCenter;wrapMode:Text.WordWrap;color:"#6C6C88";font.family:Style.Theme.fontFamily;font.pixelSize:12}
                AppCard{visible:root.step===3;Layout.fillWidth:true;Layout.preferredHeight:70;cardColor:Style.Theme.lilacSoft;strokeColor:"#E0D7F6";Text{anchors.fill:parent;anchors.margins:14;text:"ⓘ  Смотрите в сторону камеры и постарайтесь сидеть спокойно и расслабленно.";wrapMode:Text.WordWrap;verticalAlignment:Text.AlignVCenter;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:10}}

                Rectangle{visible:root.step===4;width:64;height:64;radius:32;color:Style.Theme.limeSoft;Layout.alignment:Qt.AlignHCenter;Text{anchors.centerIn:parent;text:"✓";font.pixelSize:30;color:"#27301F"}}
                Text{visible:root.step===4;text:"Калибровка завершена";Layout.fillWidth:true;horizontalAlignment:Text.AlignHCenter;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:28;font.weight:Font.Bold}
                Text{visible:root.step===4;Layout.fillWidth:true;text:"Ваша нейтральная базовая поза сохранена.";horizontalAlignment:Text.AlignHCenter;wrapMode:Text.WordWrap;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13;font.weight:Font.DemiBold}
                Text{visible:root.step===4;Layout.fillWidth:true;text:"PostureFlow будет использовать её для персонализированного распознавания вашей позы.";horizontalAlignment:Text.AlignHCenter;wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:12;lineHeight:1.3}
                AppCard{visible:root.step===4;Layout.fillWidth:true;Layout.preferredHeight:66;cardColor:"#F7F7F3";Text{anchors.centerIn:parent;text:"▣   Последняя калибровка:  "+appState.lastCalibration;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}}
                AppButton{visible:root.step===4;Layout.fillWidth:true;text:"Начать мониторинг  →";baseColor:Style.Theme.sidebar;hoverColor:"#292934";onClicked:appState.finishCalibrationAndMonitor()}
                AppButton{visible:root.step===4;Layout.fillWidth:true;text:"Готово";baseColor:"white";hoverColor:"#F7F6F4";textColor:Style.Theme.textPrimary;borderColor:Style.Theme.border;onClicked:appState.finishCalibration()}
                Item{Layout.fillHeight:true}
            }
        }

        Rectangle{Layout.fillWidth:true;height:1;color:Style.Theme.border;visible:root.step<4}
        RowLayout {
            Layout.fillWidth:true;Layout.preferredHeight:50;visible:root.step<4
            AppButton{text:"Отмена";baseColor:"white";hoverColor:"#F7F6F4";textColor:Style.Theme.textPrimary;borderColor:Style.Theme.border;onClicked:appState.cancelCalibration()}
            Item{Layout.fillWidth:true}
            AppButton{visible:root.step>1;text:"Назад";baseColor:"#F2F1F0";hoverColor:"#E9E7E4";textColor:Style.Theme.textPrimary;onClicked:appState.previousCalibration()}
            AppButton{visible:root.step<3;text:"Далее";baseColor:Style.Theme.lilacSoft;hoverColor:"#E2D8FB";textColor:Style.Theme.textPrimary;onClicked:appState.nextCalibration()}
            AppButton{visible:root.step===3;text:"Сбор данных…";enabled:false;baseColor:Style.Theme.lilacSoft;textColor:Style.Theme.textMuted}
        }
    }
}
