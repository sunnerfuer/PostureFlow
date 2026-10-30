import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    anchors.fill: parent
    property bool reminders: true
    property bool sound: true
    property bool desktop: true
    ColumnLayout {
        anchors.fill:parent;anchors.margins:30;spacing:18
        Column{spacing:4;Text{text:"Уведомления";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:30;font.weight:Font.Bold}Text{text:"Настройте, как PostureFlow будет напоминать о необходимости скорректировать позу.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14}}
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:305
            Column{anchors.fill:parent;anchors.margins:20;spacing:0
                Row{width:parent.width;height:68
                    Column{width:parent.width-70;spacing:4;Text{text:"Напоминания об осанке";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.DemiBold}Text{text:"Получайте ненавязчивое напоминание, когда стоит скорректировать позу.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                    ToggleSwitch{checked:reminders;anchors.verticalCenter:parent.verticalCenter;onToggled:reminders=checked}
                }
                Rectangle{width:parent.width;height:1;color:Style.Theme.border}
                Row{width:parent.width;height:82
                    Column{width:parent.width-240;spacing:4;Text{text:"Уведомлять, если неправильная поза сохраняется";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.DemiBold}Text{text:"Кратковременные изменения позы не учитываются.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                    AppSelect{width:210;height:44;anchors.verticalCenter:parent.verticalCenter;model:["5 секунд","10 секунд","15 секунд","30 секунд"];currentIndex:1}
                }
                Rectangle{width:parent.width;height:1;color:Style.Theme.border}
                Row{width:parent.width;height:68
                    Column{width:parent.width-70;spacing:4;Text{text:"Звук уведомлений";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.DemiBold}Text{text:"Воспроизводить тихий звук вместе с напоминанием.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                    ToggleSwitch{checked:sound;anchors.verticalCenter:parent.verticalCenter;onToggled:sound=checked}
                }
                Rectangle{width:parent.width;height:1;color:Style.Theme.border}
                Row{width:parent.width;height:68
                    Column{width:parent.width-70;spacing:4;Text{text:"Системные уведомления";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.DemiBold}Text{text:"Разрешить PostureFlow показывать системные уведомления.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                    ToggleSwitch{checked:desktop;anchors.verticalCenter:parent.verticalCenter;onToggled:desktop=checked}
                }
            }
        }
        AppCard{Layout.fillWidth:true;Layout.preferredHeight:95;cardColor:Style.Theme.goodSoft;strokeColor:"#DDEDC2";Text{anchors.fill:parent;anchors.margins:18;text:"Напоминания не должны отвлекать. PostureFlow уведомит вас только тогда, когда неправильная поза сохраняется некоторое время.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:12;verticalAlignment:Text.AlignVCenter}}
        Item{Layout.fillHeight:true}
    }
}
