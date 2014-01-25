import QtQuick 2.0

import "Game.js" as Game
import "Config.js" as Conf
Item {
    id: scene
    anchors.fill: parent

    Component {
        World {
            id: world

            Player {
                id: player
                width: Conf.gridWidth
                height: width
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    player.px = mouseX/Conf.gridWidth;
                    player.py = mouseY/Conf.gridHeight;
                }
                enabled: true
            }
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
