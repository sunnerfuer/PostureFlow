import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "theme" as Style
import "components"

ApplicationWindow {
    id: window
    width: 1440
    height: 900
    minimumWidth: 1280
    minimumHeight: 720
    visible: true
    title: "PostureFlow"
    color: Style.Theme.canvas

    // Live Monitoring is created on first visit and retained for the whole app lifetime.
    property bool livePageOpened: appState.currentPage === "live"

    Connections {
        target: appState
        function onCurrentPageChanged() {
            if (appState.currentPage === "live")
                window.livePageOpened = true
        }
    }

    function sourceForPage(page) {
        if (page === "live") return "pages/LiveMonitoringPage.qml"
        if (page === "statistics") return "pages/StatisticsPage.qml"
        if (page === "history") return "pages/HistoryPage.qml"
        if (page === "historyDetail") return "pages/HistoryDetailPage.qml"
        if (page === "settings") return "pages/SettingsPage.qml"
        return "pages/DashboardPage.qml"
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Sidebar {
            Layout.preferredWidth: Style.Theme.sidebarWidth
            Layout.fillHeight: true
            onNavigate: appState.navigate(page)
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Style.Theme.canvas

            // Do NOT unload Live Monitoring when navigating to another page.
            // Its Camera and permission state must survive navigation.
            Loader {
                id: livePageLoader
                anchors.fill: parent
                active: window.livePageOpened
                visible: appState.currentPage === "live"
                source: "pages/LiveMonitoringPage.qml"
                asynchronous: false
            }

            // All other pages can be recreated as before.
            Loader {
                id: pageLoader
                anchors.fill: parent
                visible: appState.currentPage !== "live"
                source: appState.currentPage === "live"
                        ? ""
                        : window.sourceForPage(appState.currentPage)
                asynchronous: false
            }
        }
    }

    Shortcut { sequence: "1"; onActivated: appState.setPostureState("good") }
    Shortcut { sequence: "2"; onActivated: appState.setPostureState("forward") }
    Shortcut { sequence: "3"; onActivated: appState.setPostureState("left") }
    Shortcut {
        sequence: "Space"
        onActivated: {
            if (appState.currentPage === "live") {
                if (appState.monitoringState === "active") appState.pauseMonitoring()
                else if (appState.monitoringState === "paused") appState.resumeMonitoring()
                else appState.startMonitoring()
            }
        }
    }
}
