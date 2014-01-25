import QtQuick 2.0

import "Config.js" as Conf

Rectangle {
    id: player

    property int px;
    property int py;

    property int facing: 1

    x: px*Conf.gridWidth
    y: py*Conf.gridHeight

//    property bool moving: false
    property bool moving: false

    color: "#C00"

    Behavior on x {
        PropertyAnimation {
            id:xAnim
            duration: 100
            onRunningChanged: {
                moving = running;
            }
        }

    }
    Behavior on y {
        PropertyAnimation {
            id:yAnim
            duration: 100
            onRunningChanged: {
                moving = running;
            }
        }
    }

//    onMovingChanged: { console.log(moving); }

    Rectangle {
        width: parent.width*0.5;
        height: parent.height*0.5;
        anchors.centerIn: parent
        color: "black"
    }
}
