import QtQuick 2.0

import "Config.js" as Conf

Rectangle {
    id: world
    width: 24*Conf.gridWidth
    height: 16*Conf.gridHeight
    x: scene.width/2 - width/2
    y: scene.height/2 - height/2

    color: "white"

    property bool turningLeft: false

    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: world
                rotation: (state === "right") ? 0 : 360
            }
        },
        State {
            name: "right"
            PropertyChanges {
                target: world
                rotation: 90
            }
        },
        State {
            name: "inverted"
            PropertyChanges {
                target: world
                rotation: 180
            }
        },
        State {
            name: "left"
            PropertyChanges {
                target: world
                rotation: 270
            }
        }
    ]
    state: "normal"

    transitions: [
        Transition {
            RotationAnimation {
                direction: (world.turningLeft) ?
                               RotationAnimation.Counterclockwise :
                               RotationAnimation.Clockwise
            }
        }
    ]


}
