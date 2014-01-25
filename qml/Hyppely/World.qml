import QtQuick 2.0

import "Config.js" as Conf

Item {
    id: world
    width: 24*Conf.gridWidth
    height: 16*Conf.gridHeight

    property string color: "red"
    property int colorN: 4

    property bool turningLeft: false
    property bool rotating: false

    onColorChanged: colorN = {"red":4, "green":2, "blue":1}[color]

//    onColorNChanged: console.log(colorN);

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
            onRunningChanged: rotating = running
            RotationAnimation {
                direction: (world.turningLeft) ?
                               RotationAnimation.Counterclockwise :
                               RotationAnimation.Clockwise

            }
        }
    ]

//    onRotatingChanged: console.log("rotating");
}
