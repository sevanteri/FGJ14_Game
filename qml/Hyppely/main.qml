import QtQuick 2.0

Rectangle {
    id: screen
    width: 980
    height: 600
    color: "black"


    TutorialText {}

    GameScene {
        id: scene

        x: (screen.width>980) ? screen.width/2 - width/2 :
                                 screen.width - width
        y: screen.height/2 - height/2
    }


    ListModel {
        id: buttons
        ListElement {
            title: "Quit"
            action: "Qt.quit()"
        }
        ListElement {
            title: "Restart"
            action: "scene.restart()"
        }
        ListElement {
            title: "Mute music"
            action: "scene.toggleMusic()"
        }
    }


    ListView {
        id: buttonList
        height: 40
        width: parent.width

        orientation: Qt.Horizontal
        spacing: 5

        model: buttons

        delegate: Button {
            height: 40
            width: 100

            font.pointSize: 12

            text: title
            onClicked: eval(action);
        }
    }

}
