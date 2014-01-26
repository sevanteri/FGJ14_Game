import QtQuick 2.0
import QtMultimedia 5.0

import "Game.js" as Game
import "Config.js" as Conf
Item {
    id: scene

    width: 24*Conf.gridWidth
    height: 24*Conf.gridHeight

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
                    source: "qrc:///backgrounds/images/bluebg.png"
                }
            },
            State {
                name: "green"
                PropertyChanges {
                    target: background
                    source: "qrc:///backgrounds/images/greenbg.png"
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

    Text {
        id: completeText
        text: "Congratulations!!\nThat's it!\n Good bye!"
        visible: false
        color: "white"

        opacity: 0

        anchors.centerIn: scene
        font.pointSize: 0

        SequentialAnimation {
            id: completeAnim
            ParallelAnimation {
                PropertyAnimation {
                    target: completeText
                    property: "font.pointSize"

                    from: 1
                    to: 100
                }
                PropertyAnimation {
                    target: completeText
                    property: "opacity"
                    from: 0
                    to: 1
                }
            }
        }
    }

    function restart() {
        completeText.visible = false;
        Game.nextMap = 0;
        Game.startMap(0);
        Game.createWorld();
    }

    function showWinText() {
        winText.visible = true;
        winAnim.start();
    }

    function showCompletedText() {
        completeText.visible = true;
        completeAnim.start();
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
