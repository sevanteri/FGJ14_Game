import QtQuick 2.0

import "Game.js" as Game

Rectangle {
    id: scene
    width: 480
    height: 320

    focus: true

    color: "white"

    Rectangle {
        id: player
        width: 20
        height: width

        x: scene.width/2
        y: scene.height/2

        color: "red"
    }

    Keys.onPressed: Game.handleKB(event);
}
