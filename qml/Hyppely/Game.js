.import "Maps.js" as Maps
.import "Config.js" as Conf

var map;
var blockComp;
var blocks = [];
var endBlock;
var nextMap = 0;
var mapCount = Maps.maps.length;

var downDir = {
    "normal": [0, 1],
    "right": [1, 0],
    "inverted": [0, -1],
    "left": [-1, 0]
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

function init() {
    world.rotatingChanged.connect(handlePhysics);
    world.colorChanged.connect(handleColorChanged);

    winAnim.runningChanged.connect(function() {
        if (!winAnim.running) {
            if (nextMap === mapCount) {
                scene.showCompletedText();
            } else {
                startMap(nextMap);
                createWorld();

            }

        }
    })

    startMap(nextMap);
    createWorld();
}

function startMap(n) {
    map = Maps.maps[n];
    nextMap++;

    player.disableAnimations();
    player.px = map.startpos[0];
    player.py = map.startpos[1];

    world.color = "red"
    world.state = "normal"
    player.enableAnimations();
}

function handleKB(event) {
    if (!player.moving) {
        if (event.key === Qt.Key_1) turnRed();
        else if (event.key === Qt.Key_2) turnGreen();
        else if (event.key === Qt.Key_3) turnBlue();

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
    for (var b in blocks) {
        var brick = blocks[b]
        brick.state = world.color;
        var visible = brick.colorN&world.colorN;
        brick.opacity = 0.4 + visible;
    }
    handlePhysics();
    if (collidesWithBoxes(player.px, player.py)) {
        var ddir = downDir[world.state];

        player.px -= ddir[0];
        player.py -= ddir[1];
    }
}

function collidesWithBorder(px, py) {

    if (px < 0 || px >= Conf.gridXCount |
            py < 0 || py >= Conf.gridYCount)
    {
        console.log("collided with border");
//        startMap();
        return true;
    }

    return false;
}

function collidesWithBoxes(px, py) {
    return map.map[py][px]&world.colorN;
}

function isAtEnd() {
    return (player.px === map.endpos[0] && player.py === map.endpos[1]);
}


function handleRotateLeft() {
    world.turningLeft = true;
    world.state = nextLeftOrientation[world.state];
}
function handleRotateRight() {
    world.turningLeft = false;
    world.state = nextRightOrietation[world.state];
}


function handlePhysics() {
    if (!player.moving && !world.rotating) {
        var ddir = downDir[world.state];

        var newPx = player.px;
        var newPy = player.py;

        var noBorderCollide;

        while(noBorderCollide = !collidesWithBorder(newPx + ddir[0], newPy + ddir[1]) &&
              !collidesWithBoxes(newPx + ddir[0], newPy + ddir[1])) {
            newPx += ddir[0];
            newPy += ddir[1];
        }

        player.px = newPx;
        player.py = newPy;

        if (isAtEnd()) {
            scene.showWinText();
        }
    }
}

function createWorld() {
    destroyWorld();
    blockComp = Qt.createComponent("Block.qml");

    for (var y=0; y<map.map.length; y++) {
        for (var x=0; x<map.map[y].length; x++) {
            if (map.map[y][x] !== 0) {
                var visible = map.map[y][x]&world.colorN;
                blocks.push(
                            blockComp.createObject(
                                world,
                                {
                                    "bx":x,
                                    "by":y,
                                    "opacity": 0.4 + visible,
                                    "colorN": map.map[y][x]
                                }
                                )
                            );
            }
        }
    }

    // add end position
    var endBlockComp = Qt.createComponent("EndBlock.qml");
    endBlock = endBlockComp.createObject(world, {
                                  "x": map.endpos[0]*Conf.gridWidth,
                                  "y": map.endpos[1]*Conf.gridHeight
                              });
}
function destroyWorld() {
    for (var b in blocks) {
        if (blocks[b] && typeof(blocks[b]) !== 'TypeError')
            blocks[b].destroy();
    }
    blocks = [];
    if (endBlock)
        endBlock.destroy();
}
