import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    implicitWidth: parent.width
    implicitHeight: parent.height * 0.3
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
        right: parent.right
        topMargin: 7
    }
    spacing: 2
}
