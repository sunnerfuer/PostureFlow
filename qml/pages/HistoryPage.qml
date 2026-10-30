import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Flickable {
    id: root
    clip: true
    contentWidth: width
    contentHeight: Math.max(height, content.implicitHeight + Style.Theme.pagePadding*2)

    ColumnLayout {
        id: content
        x: Style.Theme.pagePadding
        y: 14
        width: root.width - Style.Theme.pagePadding*2
        spacing: 16

        PageHeader { Layout.fillWidth:true; title:"История"; subtitle:"Просматривайте предыдущие сеансы мониторинга." }

        RowLayout {
            Layout.fillWidth:true;Layout.preferredHeight:52;spacing:14
            TextField {
                id: search
                Layout.fillWidth:true;Layout.preferredWidth:620;Layout.fillHeight:true
                placeholderText:"Поиск сеансов..."
                font.family:Style.Theme.fontFamily;font.pixelSize:13;color:Style.Theme.textPrimary
                leftPadding:44
                background: Rectangle{radius:Style.Theme.controlRadius;color:"white";border.color:Style.Theme.border}
                Text{anchors.left:parent.left;anchors.leftMargin:16;anchors.verticalCenter:parent.verticalCenter;text:"⌕";font.pixelSize:22;color:Style.Theme.textPrimary}
            }
            AppSelect{id:sessionFilter;Layout.preferredWidth:190;Layout.fillHeight:true;model:["Все сеансы","Хорошая осанка","Наклон вперёд","Наклон влево"];currentIndex:0}
            AppSelect{id:dateFilter;Layout.preferredWidth:220;Layout.fillHeight:true;model:["Последние 30 дней","Последние 7 дней","Этот месяц"];currentIndex:0}
        }

        AppCard {
            Layout.fillWidth:true
            Layout.preferredHeight:560
            Column {
                anchors.fill:parent;anchors.margins:14;spacing:10
                Row {
                    width:parent.width;height:32
                    Repeater {
                        model:[{t:"ДАТА",w:.23},{t:"ДЛИТЕЛЬНОСТЬ",w:.16},{t:"КАЧЕСТВО ОСАНКИ",w:.28},{t:"ОСНОВНАЯ ПРОБЛЕМА",w:.21},{t:"ДЕЙСТВИЕ",w:.12}]
                        delegate:Text{width:parent.width*modelData.w;text:modelData.t;color:"#6E7186";font.family:Style.Theme.fontFamily;font.pixelSize:10;font.weight:Font.Bold;font.letterSpacing:1}
                    }
                }
                Repeater {
                    model: appState.historySessions
                    delegate: Rectangle {
                        property bool matchesSearch: search.text.length===0 || modelData.date.toLowerCase().indexOf(search.text.toLowerCase())>=0 || modelData.issue.toLowerCase().indexOf(search.text.toLowerCase())>=0
                        property bool matchesIssue: sessionFilter.currentIndex===0 || (sessionFilter.currentIndex===1 && modelData.issueKey==="good") || (sessionFilter.currentIndex===2 && modelData.issueKey==="forward") || (sessionFilter.currentIndex===3 && modelData.issueKey==="left")
                        visible: matchesSearch && matchesIssue
                        width:parent.width;height:86;radius:15;color:"#FFFFFF";border.color:Style.Theme.border
                        Row {
                            anchors.fill:parent;anchors.margins:14
                            Item { width:parent.width*.23;height:parent.height
                                Row{anchors.verticalCenter:parent.verticalCenter;spacing:12
                                    Rectangle{width:38;height:38;radius:12;color:"#F6F5F7";Text{anchors.centerIn:parent;text:"▣";font.pixelSize:18;color:"#25283D"}}
                                    Column{spacing:4;Text{text:modelData.date;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.DemiBold}Text{text:modelData.time;color:"#7D86A7";font.family:Style.Theme.fontFamily;font.pixelSize:11}}
                                }
                            }
                            Item { width:parent.width*.16;height:parent.height
                                Text{anchors.verticalCenter:parent.verticalCenter;text:"◷  "+modelData.duration;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14}
                            }
                            Item { width:parent.width*.28;height:parent.height
                                Column{anchors.verticalCenter:parent.verticalCenter;spacing:6;width:parent.width-22
                                    Text{text:modelData.quality+"%";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold}
                                    Rectangle{width:parent.width;height:10;radius:5;color:"#EEEFF2";Rectangle{width:parent.width*modelData.quality/100;height:parent.height;radius:5;color:"#8FCF3C"}}
                                }
                            }
                            Item { width:parent.width*.21;height:parent.height
                                Row{anchors.verticalCenter:parent.verticalCenter;spacing:10
                                    Rectangle{width:14;height:14;radius:7;color:Style.Theme.postureColor(modelData.issueKey)}
                                    Text{text:modelData.issue;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:13}
                                }
                            }
                            Item { width:parent.width*.12;height:parent.height
                                AppButton{anchors.centerIn:parent;width:105;height:42;text:"Открыть  →";baseColor:"white";hoverColor:"#F7F6F4";textColor:Style.Theme.textPrimary;borderColor:Style.Theme.border;onClicked:appState.openSession(index)}
                            }
                        }
                    }
                }
            }
        }
    }
}
