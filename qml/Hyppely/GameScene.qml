import QtQuick 2.0

import "Game.js" as Game
import "Config.js" as Conf
Item {
    id: scene
    anchors.fill: parent

    World {
        id: world

        Player {
            id: player
            width: Conf.gridWidth
            height: width
            px: 6
            py: 14
        }
    }

    function createWorld() {
        Game.createWorld();
    }

    function runPhys() {
        Game.handlePhysics();
    }

    Component.onCompleted: Game.init();

    focus: true
    Keys.onPressed: Game.handleKB(event);
}
