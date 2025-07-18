import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    id: root
    Variants {
        model: Quickshell.screens
        delegate: Component {

            PanelWindow {
                implicitWidth: 50
                implicitHeight: screen.height * 0.8
                anchors {
                    left: true
                }

                ColumnLayout {
                    anchors {
                        fill: parent
                    }

                    BarClock {
                        anchors {
                            top: parent.top
                        }
                    }
                }
            }
        }
    }
}
