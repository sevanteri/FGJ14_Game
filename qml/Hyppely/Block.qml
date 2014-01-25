import QtQuick 2.0

import "Config.js" as Conf

Image {
    id: brick
    property int bx;
    property int by;

    property int colorN: 4
    state: "red"

    states: [
        State {
            name: "red"
            PropertyChanges {
                target: brick
                source: "qrc:///bricks/images/brick24.png"
            }
        },

        State {
            name: "blue"
            PropertyChanges {
                target: brick
                source: "qrc:///bricks/images/blubrick.png"
            }
        },

        State {
            name: "green"
            PropertyChanges {
                target: brick
                source: "qrc:///bricks/images/blubrick.png"
            }
        }
    ]

    x: bx*Conf.gridWidth
    y: by*Conf.gridHeight

    width: Conf.gridWidth
    height: Conf.gridHeight

    source: "qrc:///bricks/images/brick24.png"

}
