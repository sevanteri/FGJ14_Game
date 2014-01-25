.import "Maps.js" as Maps
.import "Config.js" as Conf

var map;
var blockComp;
var blocks;

function init() {
    map = Maps.map1Red;
    blocks = map.slice(0); // clone

    player.movingChanged.connect(handlePhysics);

    createWorld();
}

function handleKB(event) {
    if (!player.moving) {
        if (event.key === Qt.Key_Up) handleUp();
        else if (event.key === Qt.Key_Down) handleDown();
        else if (event.key === Qt.Key_Left) handleLeft();
        else if (event.key === Qt.Key_Right) handleRight();

        else if (event.key === Qt.Key_Z) handleRotateLeft();
        else if (event.key === Qt.Key_X) handleRotateRight();
    }
}


function handleLeft() {
    moveTo(-1, 0);
}

function handleRight() {
    moveTo(1, 0);
}

function handleUp() {
    jump();
}

function handleDown() {
    moveTo(0, 1);
}

function moveTo(px, py) {
    var collides = false;

    var helper = py;
    if (world.state === "left") {
        py = px;
        px = -helper;
    }
    else if (world.state === "inverted") {
        py = -py;
        px = -px;
    }
    else if (world.state === "right") {
        py = -px;
        px = helper;
    }

    var newPx = player.px + px;
    var newPy = player.py + py;

    //    console.log(player.px, newPx, player.py, newPy);

    collides = collidesWithBorder(newPx, newPy);
    collides = (collides || collidesWithBoxes(newPx, newPy));
    if (!collides) {
//        player.moving = true;
        player.px = newPx;
        player.py = newPy;
    }
//    player.moving = false;
}

function jump() {
    var py = -4;
    var px = 4;
    var helper = py;
    if (world.state === "left") {
        py = px;
        px = -helper;
    }
    else if (world.state === "inverted") {
        py = -py;
        px = -px;
    }
    else if (world.state === "right") {
        py = -px;
        px = helper;
    }

    player.px += px;
    player.py += py;

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
    handlePhysics();
}
function handleRotateRight() {
    world.turningLeft = false;
    world.state = nextRightOrietation[world.state];
    handlePhysics();
}

var downDir = {
    "normal": [0, 1],
    "right": [1, 0],
    "inverted": [0, -1],
    "left": [-1, 0]
}
function handlePhysics() {
    if (!player.moving) {
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
                blocks[y][x] = blockComp.createObject(world, {"bx":x, "by":y});
        }
    }

}
