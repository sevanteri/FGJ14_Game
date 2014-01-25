import QtQuick 2.0

Item {
    anchors.fill: parent

    Text {
        x: parent.width/8
        y: parent.height/2 - height/2
        text: "Z: RED\nX: GREEN\nC: BLUE"
        font.pointSize: 20
        color: "white"
    }


    Text {
        x: parent.width/8*6
        y: parent.height/2 - height/2

        font.pointSize: 20
        color: "white"
        text: "Left: COUNTER-CLOCKWISE\nRight: CLOCKWISE"
    }
}
