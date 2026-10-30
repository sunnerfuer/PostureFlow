import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../theme" as Style
import "../components"

Item {
    id: root
    property int periodIndex: 1
    property real uiScale: Math.min(1.0, height / 900.0)

    property var chartValues: periodIndex === 0
                              ? [76,81,79,84,82,86]
                              : (periodIndex === 2
                                 ? [73,76,78,82]
                                 : appState.weeklyQuality)

    property var chartLabels: periodIndex === 0
                              ? ["09","11","13","15","17","19"]
                              : (periodIndex === 2
                                 ? ["W1","W2","W3","W4"]
                                 : appState.weeklyLabels)

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

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.round(72 * root.uiScale)
            Column {
                anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter; spacing:3
                Text{text:"Статистика";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:Style.Theme.pageTitle;font.weight:Font.Bold}
                Text{text:"Посмотрите, как меняется ваша осанка со временем.";color:"#657095";font.family:Style.Theme.fontFamily;font.pixelSize:14}
            }
            Row {
                anchors.right:parent.right;anchors.verticalCenter:parent.verticalCenter;spacing:16
                SegmentedControl { width:300; currentIndex:root.periodIndex; options:["День","Неделя","Месяц"]; onSelected: root.periodIndex = index }
                Rectangle { width:1;height:34;color:Style.Theme.border;anchors.verticalCenter:parent.verticalCenter }
                Text{text:root.periodIndex===0?"▣   13 сентября":(root.periodIndex===2?"▣   Сентябрь":"▣   7 — 13 сентября");color:"#556080";font.family:Style.Theme.fontFamily;font.pixelSize:13;anchors.verticalCenter:parent.verticalCenter}
                Rectangle {width:38;height:38;radius:19;color:"white";border.color:Style.Theme.border;Text{anchors.centerIn:parent;text:"♧";font.pixelSize:20;color:Style.Theme.textPrimary}}
                Rectangle{width:42;height:42;radius:21;clip:true;Image{anchors.fill:parent;source:"../../assets/avatar.png";fillMode:Image.PreserveAspectCrop}}
            }
        }

        RowLayout {
            Layout.fillWidth:true;Layout.preferredHeight:Math.round(170 * root.uiScale);spacing:Math.round(16 * root.uiScale)
            MetricCard{Layout.fillWidth:true;Layout.fillHeight:true;title:"КАЧЕСТВО ОСАНКИ";value:appState.statisticsSummary.quality+"%";footnote:"↑  7% к прошлой неделе";accent:Style.Theme.lilac;softColor:Style.Theme.lilacSoft;iconText:"☺"}
            AppCard {
                Layout.fillWidth:true;Layout.fillHeight:true;cardColor:Style.Theme.goodSoft;strokeColor:"#DDEDC2"
                Row{anchors.fill:parent;anchors.margins:20;spacing:12
                    Column{width:parent.width-112;spacing:5
                        Text{text:"ХОРОШАЯ ОСАНКА";color:"#455261";font.family:Style.Theme.fontFamily;font.pixelSize:11;font.weight:Font.Bold;font.letterSpacing:1}
                        Text{text:appState.statisticsSummary.goodTime;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:38;font.weight:Font.Bold}
                        Text{text:appState.statisticsSummary.goodPercent+"% времени мониторинга";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:14;font.weight:Font.DemiBold}
                    }
                    CircularProgress{width:90;height:90;value:.76;accent:"#70B623";track:"#DCECC2";strokeWidth:10;anchors.verticalCenter:parent.verticalCenter;Text{anchors.centerIn:parent;text:"76%";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:18;font.weight:Font.Bold}}
                }
            }
            MetricCard{Layout.fillWidth:true;Layout.fillHeight:true;title:"КОРРЕКТИРОВКИ";value:appState.statisticsSummary.corrections;footnote:"↓  12% к прошлой неделе";accent:Style.Theme.peach;softColor:Style.Theme.peachSoft;iconText:"✎"}
        }

        RowLayout {
            Layout.fillWidth:true;Layout.preferredHeight:Math.round(335 * root.uiScale);spacing:Math.round(16 * root.uiScale)
            AppCard {
                Layout.fillWidth:true;Layout.preferredWidth:760;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:18;spacing:3
                    Row{width:parent.width
                        Column{width:parent.width-110;spacing:3
                            Text{text:"Качество осанки в динамике";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:19;font.weight:Font.Bold}
                            Text{text:"Доля времени мониторинга в нейтральной позе";color:"#667092";font.family:Style.Theme.fontFamily;font.pixelSize:12}
                        }
                        AppSelect{width:100;model:["Неделя","Месяц"];currentIndex:0}
                    }
                    LineChart{width:parent.width;height:Math.round(250 * root.uiScale);values:root.chartValues;labels:root.chartLabels}
                }
            }
            AppCard {
                Layout.fillWidth:true;Layout.preferredWidth:330;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:18;spacing:11
                    Text{text:"Распределение поз";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:19;font.weight:Font.Bold}
                    Text{text:"Среднее распределение поз за неделю";color:"#667092";font.family:Style.Theme.fontFamily;font.pixelSize:12}
                    Item{height:3;width:1}
                    Repeater{model:appState.postureDistribution;delegate:DistributionBar{width:parent.width;height:62;label:modelData.label;value:modelData.value;accent:Style.Theme.postureColor(modelData.key)}}
                }
            }
        }

        RowLayout {
            Layout.fillWidth:true;Layout.preferredHeight:Math.round(205 * root.uiScale);spacing:Math.round(16 * root.uiScale)
            AppCard {
                Layout.fillWidth:true;Layout.preferredWidth:310;Layout.fillHeight:true;cardColor:Style.Theme.forwardSoft;strokeColor:"#F2CDBE"
                Column{anchors.fill:parent;anchors.margins:20;spacing:8
                    Text{text:"Самая частая проблема";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold}
                    Text{text:appState.statisticsSummary.commonIssue;color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:27;font.weight:Font.Bold}
                    Text{text:appState.statisticsSummary.commonIssueTime+" на этой неделе";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.DemiBold}
                    Text{text:"↓  18% по сравнению с прошлой неделей";color:"#449E27";font.family:Style.Theme.fontFamily;font.pixelSize:12;font.weight:Font.DemiBold}
                }
            }
            AppCard {
                Layout.fillWidth:true;Layout.preferredWidth:440;Layout.fillHeight:true
                Column{anchors.fill:parent;anchors.margins:16;spacing:2
                    Row{width:parent.width
                        Column{width:parent.width-100;Text{text:"Корректировки по дням";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold}Text{text:"Всего 24 корректировки";color:"#667092";font.family:Style.Theme.fontFamily;font.pixelSize:12}}
                        AppSelect{width:90;model:["Неделя"];currentIndex:0}
                    }
                    BarChart{width:parent.width;height:Math.round(140 * root.uiScale);values:appState.correctionsByDay;labels:appState.weeklyLabels}
                }
            }
            AppCard {
                Layout.fillWidth:true;Layout.preferredWidth:300;Layout.fillHeight:true;cardColor:Style.Theme.lilacSoft;strokeColor:"#DED2F7"
                Column{anchors.fill:parent;anchors.margins:20;spacing:10
                    Text{text:"Стабильность";color:"#403273";font.family:Style.Theme.fontFamily;font.pixelSize:17;font.weight:Font.Bold}
                    Row{spacing:8;Text{text:appState.statisticsSummary.consistencyDays+" / 7";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:38;font.weight:Font.Bold}Text{text:"дней";color:Style.Theme.textPrimary;font.family:Style.Theme.fontFamily;font.pixelSize:21;font.weight:Font.DemiBold;anchors.bottom:parent.bottom; anchors.bottomMargin:5}}
                    Text{width:parent.width;text:"В течение пяти дней на этой неделе вы сохраняли нейтральную позу не менее 75% времени.";wrapMode:Text.WordWrap;color:"#596080";font.family:Style.Theme.fontFamily;font.pixelSize:13;lineHeight:1.25}
                }
            }
        }
    }
}
