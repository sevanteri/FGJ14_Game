var gridXCount = 24;
var gridYCount = 16;

var gridWidth = 20;
var gridHeight = gridWidth;


function handleKB(event) {
    if (event.key === Qt.Key_Up) handleUp();
    else if (event.key === Qt.Key_Down) handleDown();
    else if (event.key === Qt.Key_Left) handleLeft();
    else if (event.key === Qt.Key_Right) handleRight();
}


function handleLeft() {
    moveTo(player.x - 20, player.y);
}

function handleRight() {
    moveTo(player.x + 20, player.y);
}

function handleUp() {
    moveTo(player.x, player.y - 20);
}

function handleDown() {
    moveTo(player.x, player.y + 20);
}

function moveTo(x, y) {
    var collides = false;
    if (player.x !== x) {
        collides = collidesWithBorder(x, y);
        if (!collides)
            player.x = x;
    }
    else if (player.y !== y) {
        collides = collidesWithBorder(x, y);
        if (!collides)
            player.y = y;
    }
}

function collidesWithBorder(x, y) {

    if (Math.floor(x/gridWidth) < 0 |
        Math.floor(x/gridWidth) >= gridXCount |
        Math.floor(y/gridHeight) < 0 |
        Math.floor(y/gridHeight) >= gridYCount)
    {
        return true;
    }

    return false;
}
