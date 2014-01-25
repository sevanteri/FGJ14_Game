import QtQuick 2.0

import "Config.js" as Conf

Rectangle {
    id: player

    property int px;
    property int py;

    property int facing: 1

    x: px*Conf.gridWidth
    y: py*Conf.gridHeight

    property bool moving: false

    color: "#C00"

    Behavior on x {
        id: xBehavior
        PropertyAnimation {
            id:xAnim
            duration: 100 * Math.abs(to - from) + 1
            onRunningChanged: {
                moving = running;
            }
        }

    }
    Behavior on y {
        id: yBehavior
        PropertyAnimation {
            id:yAnim
            duration: 100 * Math.abs(to - from) + 1
            onRunningChanged: {
                moving = running;
            }
        }
    }

    function enableAnimations() {
        xBehavior.enabled = yBehavior.enabled = true;
    }
    function disableAnimations() {
        xBehavior.enabled = yBehavior.enabled = false;
    }


//    onMovingChanged: { console.log(moving); }

    Rectangle {
        width: parent.width*0.5;
        height: parent.height*0.5;
        anchors.centerIn: parent
        color: "black"
    }
}
