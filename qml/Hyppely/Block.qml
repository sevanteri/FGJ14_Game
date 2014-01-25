import QtQuick 2.0

import "Config.js" as Conf

Rectangle {
    property int bx;
    property int by;

    x: bx*Conf.gridWidth
    y: by*Conf.gridHeight

    width: Conf.gridWidth
    height: Conf.gridHeight
    color: "red"


}
