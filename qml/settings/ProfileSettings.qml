import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    anchors.fill:parent
    ColumnLayout {
        anchors.fill:parent;anchors.margins:30;spacing:18
        Column{spacing:4;Text{text:"Профиль";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:30;font.weight:Font.Bold}Text{text:"Настройте основные параметры ежедневного мониторинга.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14}}
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:330
            Column{anchors.fill:parent;anchors.margins:22;spacing:18
                Row{width:parent.width;height:72;spacing:14
                    Rectangle{width:64;height:64;radius:32;clip:true;Image{anchors.fill:parent;source:"../../assets/avatar.png";fillMode:Image.PreserveAspectCrop}}
                    Column{anchors.verticalCenter:parent.verticalCenter;spacing:3;Text{text:"Мария";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:18;font.weight:Font.Bold}Text{text:"Профиль PostureFlow";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                }
                Column{width:parent.width;spacing:7;Text{text:"Имя";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}TextField{width:parent.width;height:46;text:"Мария";font.family:Style.Theme.fontFamily;font.pixelSize:13;color:Style.Theme.textPrimary;leftPadding:14;background:Rectangle{radius:Style.Theme.controlRadius;color:"white";border.color:Style.Theme.border}}}
                Row{width:parent.width;spacing:18
                    Column{width:(parent.width-18)/2;spacing:7;Text{text:"Цель мониторинга по умолчанию";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}AppSelect{width:parent.width;model:["1 час в день","2 часа в день","3 часа в день"];currentIndex:1}}
                    Column{width:(parent.width-18)/2;spacing:7;Text{text:"Начало недели";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}AppSelect{width:parent.width;model:["Понедельник","Воскресенье"];currentIndex:0}}
                }
            }
        }
        AppCard{Layout.fillWidth:true;Layout.preferredHeight:90;cardColor:Style.Theme.goodSoft;strokeColor:"#DDEDC2";Text{anchors.fill:parent;anchors.margins:18;text:"Цель мониторинга используется только для отображения прогресса и не является медицинской рекомендацией.";wrapMode:Text.WordWrap;color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:12;verticalAlignment:Text.AlignVCenter}}
        Item{Layout.fillHeight:true}
    }
}
