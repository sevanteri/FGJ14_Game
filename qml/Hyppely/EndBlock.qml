import QtQuick 2.0

import "Config.js" as Conf

Image {
    width: Conf.gridWidth
    height: Conf.gridHeight

    source: "qrc:///bricks/images/end.png"

    PropertyAnimation on rotation{
        running: true;
        from: 0
        to: 359
        duration: 1000
        loops: RotationAnimation.Infinite
    }
}
