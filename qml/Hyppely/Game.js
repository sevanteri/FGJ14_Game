var gridXCount = 24;
var gridYCount = 16;

var gridWidth = 24;
var gridHeight = gridWidth;


function handleKB(event) {
    if (!player.moving) {
        player.moving = true;
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
    moveTo(0, -1);
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
    var newPy = player.py + py

//    console.log(player.px, newPx, player.py, newPy);

    if (newPx !== player.px) {
        collides = collidesWithBorder(newPx, newPy);
        if (!collides)
            player.px = newPx;
    }
    else if (newPy !== player.py) {
        collides = collidesWithBorder(newPx, newPy);
        if (!collides)
            player.py = newPy;
    }
    player.moving = false;
}

function collidesWithBorder(px, py) {

    if (px < 0 | px >= gridXCount |
        py < 0 | py >= gridYCount)
    {
        return true;
    }

    return false;
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
