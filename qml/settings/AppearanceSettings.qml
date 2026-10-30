import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    anchors.fill:parent
    property int themeIndex:0
    property int accentIndex:0
    property int densityIndex:0
    ColumnLayout {
        anchors.fill:parent;anchors.margins:30;spacing:18
        Column{spacing:4;Text{text:"Оформление";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:30;font.weight:Font.Bold}Text{text:"Настройте внешний вид PostureFlow под себя.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:14}}
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:170
            Column{anchors.fill:parent;anchors.margins:20;spacing:14
                Text{text:"Тема";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.Bold}
                Row{width:parent.width;spacing:12
                    Repeater{model:["Светлая","Тёмная","Системная"];delegate:Rectangle{width:(parent.width-24)/3;height:82;radius:14;color:themeIndex===index?Style.Theme.lilacSoft:"#FBFAF8";border.color:themeIndex===index?Style.Theme.lilac:Style.Theme.border
                        Column{anchors.centerIn:parent;spacing:7;Rectangle{width:34;height:24;radius:7;color:index===0?"white":(index===1?Style.Theme.sidebar:"#E8E7E4");border.color:Style.Theme.border}Text{text:modelData;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:themeIndex===index?Font.DemiBold:Font.Normal;anchors.horizontalCenter:parent.horizontalCenter}}
                        MouseArea{anchors.fill:parent;cursorShape:Qt.PointingHandCursor;onClicked:themeIndex=index}
                    }}
                }
            }
        }
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:150
            Column{anchors.fill:parent;anchors.margins:20;spacing:14
                Text{text:"Цветовой акцент";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.Bold}
                Row{spacing:14
                    Repeater{model:[{n:"Мягкий сиреневый",c:Style.Theme.lilac},{n:"Лаймовый",c:Style.Theme.lime},{n:"Персиковый",c:Style.Theme.peach}];delegate:Rectangle{width:165;height:72;radius:14;color:accentIndex===index?"#FAF8FF":"#FBFAF8";border.color:accentIndex===index?modelData.c:Style.Theme.border
                        Row{anchors.centerIn:parent;spacing:10;Rectangle{width:24;height:24;radius:12;color:modelData.c}Text{text:modelData.n;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:12}}
                        MouseArea{anchors.fill:parent;cursorShape:Qt.PointingHandCursor;onClicked:accentIndex=index}
                    }}
                }
            }
        }
        AppCard {
            Layout.fillWidth:true;Layout.preferredHeight:135
            Column{anchors.fill:parent;anchors.margins:20;spacing:14
                Text{text:"Плотность интерфейса";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.Bold}
                SegmentedControl{width:340;options:["Комфортная","Компактная"];currentIndex:densityIndex;onSelected:densityIndex=index}
                Text{text:"Комфортные отступы соответствуют основному макету приложения.";color:Style.Theme.textSecondary;font.family:Style.Theme.fontFamily;font.pixelSize:11}
            }
        }
        Item{Layout.fillHeight:true}
    }
}
