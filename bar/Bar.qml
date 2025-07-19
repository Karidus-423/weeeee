import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Scope {
    id: root
    Variants {
        model: Quickshell.screens
        delegate: Component {

            PanelWindow {
                implicitWidth: 60
                implicitHeight: screen.height * 0.8
                exclusiveZone: implicitWidth
                color: "#4e5f63"

                anchors {
                    left: true
                }

                ColumnLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 15
                        topMargin: 20
                        bottomMargin: 20
                    }

                    BarSection {
                        id: bar_top
                    }

                    BarSection {
                        id: bar_middle
                        BarClock {}
                        BarWorkspaces {
                            bar: root
                        }
                    }

                    BarSection {
                        id: bar_bottom
                    }
                }
            }
        }
    }
}
