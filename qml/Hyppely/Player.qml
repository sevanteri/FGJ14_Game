import QtQuick 2.0

import "Game.js" as Game

Rectangle {
    id: player

    property int px;
    property int py;

    property bool moving: false;

    x: px*Game.gridWidth
    y: py*Game.gridHeight

    color: "red"

//            Behavior on x { PropertyAnimation {} }
}
