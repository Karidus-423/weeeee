import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

// palette = 0=#303E37
// palette = 1=#634e4e
// palette = 2=#4e635a
// palette = 3=#727358
// palette = 4=#4e5f63
// palette = 5=#615f3b
// palette = 6=#717F71
// palette = 7=#737f7f

Scope {
    id: root

    // Bind the pipewire node so its volume will be tracked
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

    property bool shouldShowOsd: false

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    // The OSD window will be created and destroyed based on shouldShowOsd.
    // PanelWindow.visible could be set instead of using a loader, but using
    // a loader will reduce the memory overhead when the window isn't open.
    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            // Since the panel's screen is unset, it will be picked by the compositor
            // when the window is created. Most compositors pick the current active monitor.

            anchors {
                top: true
                right: true
            }
            margins {
                right: screen.height * 0.06
                top: 10
            }

            implicitWidth: 50
            implicitHeight: 400
            color: "transparent"

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: 5
                color: "#4e5f63"

                ColumnLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 15
                        topMargin: 20
                        bottomMargin: 20
                    }

                    Rectangle {
                        // Stretches to fill all left-over space
                        Layout.fillHeight: true
                        Layout.leftMargin: 10

                        implicitWidth: 10
                        radius: 1
                        color: "#737f7f"

                        Rectangle {
                            color: "#303E37"
                            anchors {
                                bottom: parent.bottom
                                left: parent.left
                                right: parent.right
                            }

                            implicitHeight: parent.height * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                            radius: parent.radius
                        }
                    }

                    IconImage {
                        implicitSize: 30
                        source: Quickshell.iconPath("/home/kennett/dotfiles/.config/quickshell/assets/volume-high.svg")
                    }
                }
            }
        }
    }
}
