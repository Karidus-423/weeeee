pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Hyprland

// palette = 0=#303E37
// palette = 1=#634e4e
// palette = 2=#4e635a
// palette = 3=#727358
// palette = 4=#4e5f63
// palette = 5=#615f3b
// palette = 6=#717F71
// palette = 7=#737f7f

MouseArea {
    id: root

    required property var bar
    property int wsBaseIndex: 1
    property int wsCount: 7
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)
    property int currentIndex: 0
    property int existsCount: 0

    signal workspaceAdded(workspace: HyprlandWorkspace)

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    acceptedButtons: Qt.NoButton

    onWheel: e => {
        e.accepted = true;
        const step = -Math.sign(e.angleDelta.y);
        const targetWs = currentIndex + step;

        if (targetWs >= wsBaseIndex && targetWs < wsBaseIndex + wsCount) {
            Hyprland.dispatch(`workspace ${targetWs}`);
        }
    }

    ColumnLayout {
        id: row

        anchors.fill: parent
        spacing: 8

        Repeater {
            model: root.wsCount

            MouseArea {
                id: wsItem

                required property int index
                property int wsIndex: root.wsBaseIndex + index
                property HyprlandWorkspace workspace: null
                property bool exists: workspace != null
                property bool active: (root.monitor?.activeWorkspace ?? false) && root.monitor.activeWorkspace == workspace

                implicitWidth: 26
                implicitHeight: 26

                acceptedButtons: Qt.LeftButton

                onPressed: Hyprland.dispatch(`workspace ${wsIndex}`)

                onExistsChanged: {
                    root.existsCount += exists ? 1 : -1;
                }

                onActiveChanged: {
                    if (active)
                        root.currentIndex = wsIndex;
                }

                Connections {
                    target: root

                    function onWorkspaceAdded(workspace: HyprlandWorkspace) {
                        if (workspace.id == wsItem.wsIndex) {
                            wsItem.workspace = workspace;
                        }
                    }
                }

                Rectangle {
                    id: fill
                    anchors.fill: parent
                    anchors.margins: 2
                    radius: width * 0.3
                    color: wsItem.exists ? "#303E37" : "#615f3b"
                }
                Image {
                    anchors.fill: parent
                    smooth: false
                    source: "/home/zac/assets/workspace.png"
                }
                MultiEffect {
                    source: fill
                    anchors.fill: fill
                    blur: 1.0
                    brightness: 0.3
                    blurEnabled: true
                    visible: wsItem.active
                    opacity: wsItem.active ? 1.0 : 0
                    Behavior on opacity {
                        NumberAnimation {
                            duration: 100
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: Hyprland.workspaces

        function onObjectInsertedPost(workspace) {
            root.workspaceAdded(workspace);
        }
    }

    Component.onCompleted: {
        Hyprland.workspaces.values.forEach(workspace => {
            root.workspaceAdded(workspace);
        });
    }
}
