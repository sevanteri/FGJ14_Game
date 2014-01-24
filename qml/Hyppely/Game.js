var GridWidth = 24;
var GridHeight = 16;

function handleKB(event) {
    if (event.key === Qt.Key_Up) handleUp();
    else if (event.key === Qt.Key_Down) handleDown();
    else if (event.key === Qt.Key_Left) handleLeft();
    else if (event.key === Qt.Key_Right) handleRight();
}


function handleLeft() {
    player.x -= 20;
}

function handleRight() {
    player.x += 20;
}

function handleUp() {
    player.y -= 20;
}

function handleDown() {
    player.y += 20;
}

function moveTo(x, y) {
    if (player.x !== x) {

    }
    else if (player.y !== y) {

    }
}

function collidesWithBorder(x, y) {

}
