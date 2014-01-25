import QtQuick 2.0

Rectangle {
    id: button
    signal clicked

    property alias text: txt.text
    property alias font: txt.font

    Text {
        id: txt
        anchors.centerIn: button
    }

    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
    }
}
