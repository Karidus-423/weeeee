import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#ffffff"
    Layout.alignment: Qt.AlignVCenter
    implicitWidth: 50
    implicitHeight: parent.height * 0.1

    Text {
        font.pointSize: 12
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        text: TimeProcess.curr_time
    }
}
