.import "Maps.js" as Maps
.import "Config.js" as Conf

var map;
var blockComp;
var blocks = [];

function init() {
    map = Maps.map1Red;

    world.rotatingChanged.connect(handlePhysics);
    world.colorChanged.connect(handleColorChanged);

    createWorld();
}

function handleKB(event) {
    if (!player.moving) {
        if (event.key === Qt.Key_Z) turnRed();
        else if (event.key === Qt.Key_X) turnGreen();
        else if (event.key === Qt.Key_C) turnBlue();

        else if (event.key === Qt.Key_Left) handleRotateLeft();
        else if (event.key === Qt.Key_Right) handleRotateRight();
    }
}
function turnRed() {
    world.color = "red";
}
function turnGreen() {
    world.color = "green"
}
function turnBlue() {
    world.color = "blue"
}

function handleColorChanged() {
    for (var brick in blocks) {
        blocks[brick].state = world.color;
    }
}

function collidesWithBorder(px, py) {

    if (px < 0 || px >= Conf.gridXCount |
            py < 0 || py >= Conf.gridYCount)
    {
        return true;
    }

    return false;
}

function collidesWithBoxes(px, py) {
    return map[py][px];
}

var nextRightOrietation = {
    "normal":"right",
    "right":"inverted",
    "inverted":"left",
    "left":"normal"
};
var nextLeftOrientation = {
    "normal":"left",
    "left":"inverted",
    "inverted":"right",
    "right":"normal"
};
function handleRotateLeft() {
    world.turningLeft = true;
    world.state = nextLeftOrientation[world.state];
}
function handleRotateRight() {
    world.turningLeft = false;
    world.state = nextRightOrietation[world.state];
}

var downDir = {
    "normal": [0, 1],
    "right": [1, 0],
    "inverted": [0, -1],
    "left": [-1, 0]
}
function handlePhysics() {
    if (!player.moving && !world.rotating) {
        var ddir = downDir[world.state];

        var newPx = player.px;
        var newPy = player.py;

        while(!collidesWithBorder(newPx + ddir[0], newPy + ddir[1]) &&
            !collidesWithBoxes(newPx + ddir[0], newPy + ddir[1])) {
            newPx += ddir[0];
            newPy += ddir[1];
        }
        player.px = newPx;
        player.py = newPy;
    }
}

function createWorld() {
    blockComp = Qt.createComponent("Block.qml");

    for (var y=0; y<map.length; y++) {
        for (var x=0; x<map[y].length; x++) {
            if (map[y][x])
                blocks.push(blockComp.createObject(world, {"bx":x, "by":y}));
        }
    }

}
