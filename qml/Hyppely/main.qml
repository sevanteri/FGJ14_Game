import QtQuick 2.0

Rectangle {
    id: screen
    width: 600
    height: 600
    color: "black"

    GameScene {
        id: scene
        x: screen.width/2 - width/2
        y: screen.height/2 - height/2
    }

    Button {
        id: quitButton
        height: 40
        width: 100
        text: "Quit"
        onClicked: {
            Qt.quit();
        }
    }

    Button {
        id: createButton
        height: 40
        width: 100
        text: "Create World"

        anchors.left: quitButton.right
        anchors.leftMargin: 10

        onClicked: scene.createWorld();
    }

    Button {
        height: 40
        width: 100
        text: "Show win text"

        anchors.left: createButton.right
        anchors.leftMargin: 10

        onClicked: scene.showWinText();
    }

}
