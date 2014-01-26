import QtQuick 2.0

Item {
    anchors.fill: parent

    Text {
        x: 25
        y: parent.height/2 - height/2
        text: "Z: RED\nX: GREEN\nC: BLUE\n\nLeft: COUNTER-CLOCKWISE\nRight: CLOCKWISE"
        font.pointSize: 20
        color: "white"
    }
}
