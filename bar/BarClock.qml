import QtQuick
import QtQuick.Layouts

import "../utils" as Utils

Rectangle {
    id: root
    color: "transparent"
    Layout.alignment: Qt.AlignVCenter
    implicitWidth: parent.width
    implicitHeight: parent.height * 0.1

    Text {
        font.pointSize: 18
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        text: Utils.TimeProcess.curr_time
    }
}
