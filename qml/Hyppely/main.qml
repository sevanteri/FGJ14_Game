import QtQuick 2.0

Rectangle {
    id: screen
    width: 600
    height: 600
    color: "black"

    GameScene {
        x: screen.width/2 - width/2
        y: screen.height/2 - height/2
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
}
