import QtQuick 2.0
import QtMultimedia 5.0

import "Game.js" as Game
import "Config.js" as Conf
Item {
    id: scene

    width: 24*Conf.gridWidth
    height: 24*Conf.gridHeight

    Audio {
        id: musicPlayer
        autoLoad: true
        autoPlay: true
        source: "qrc:///sounds/sounds/Dream Culture.mp3"
    }

    Image {
        id: background
        source: "qrc:///backgrounds/images/redcave.png"
        anchors.centerIn: world
        states: [
            State {
                name: "red"
                PropertyChanges {
                    target: background
                    source: "qrc:///backgrounds/images/redcave.png"
                }
            },
            State {
                name: "blue"
                PropertyChanges {
                    target: background
                    source: "qrc:///backgrounds/images/redcave.png"
                }
            },
            State {
                name: "green"
                PropertyChanges {
                    target: background
                    source: "qrc:///backgrounds/images/redcave.png"
                }
            }
        ]
    }

    World {
        id: world

        x: parent.width/2 - width/2
//        x: parent.width
        y: parent.height/2 - height/2

        Player {
            id: player
            width: Conf.gridWidth
            height: width
        }

        onColorChanged: background.state = world.color




        // just for debugging
        MouseArea {
            anchors.fill: parent
            onClicked: {
                player.px = mouseX/Conf.gridWidth;
                player.py = mouseY/Conf.gridHeight;
            }
            enabled: false
        }
        Component.onCompleted: Game.init();
    }


    Text {
        id: winText
        text: "Fantastic!!"
        visible: false
        color: "white"

        opacity: 0

        anchors.centerIn: scene
        font.pointSize: 0

        SequentialAnimation {
            id: winAnim
            ParallelAnimation {
                PropertyAnimation {
                    target: winText
                    property: "font.pointSize"

                    from: 1
                    to: 100
                }
                PropertyAnimation {
                    target: winText
                    property: "opacity"
                    from: 0
                    to: 1
                }
            }

            PropertyAnimation {
                target: winText
                property: "opacity"
                from: 1
                to: 0
                easing.type: Easing.InCubic
                duration: 1000
            }
        }
    }


    function restart() {
        Game.startMap(0);
    }

    function showWinText() {
        winText.visible = true;
        winAnim.start();
    }

    function toggleMusic() {
        if (musicPlayer.playbackState === Audio.PausedState)
            musicPlayer.play();
        else
            musicPlayer.pause();
    }

    focus: true
    Keys.onPressed: Game.handleKB(event);


}
