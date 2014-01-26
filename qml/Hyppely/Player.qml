import QtQuick 2.0

import "Config.js" as Conf

Image {
    id: player

    property int px;
    property int py;

    property int facing: 1

    x: px*Conf.gridWidth
    y: py*Conf.gridHeight

    property bool moving: false

    source: "qrc:///bricks/images/dude.png"

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

    SequentialAnimation on height {
        id: squeezeAnim
        running: false
        PropertyAnimation{
            target: player
            property: "height"
            to: height*0.8
            duration: 100
        }
        PropertyAnimation{
            target: player
            property: "height"
            to: Conf.gridHeight
            duration: 100
        }
    }
    onMovingChanged: {
        if (!moving) squeezeAnim.start();
    }

//    onMovingChanged: { console.log(moving); }
}
