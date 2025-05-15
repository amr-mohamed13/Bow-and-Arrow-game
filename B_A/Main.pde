// Main File (sketch)

// Import the Processing sound library for sound effects
import processing.sound.*;
// Declare SoundFile objects for various sound effects
SoundFile arwSound;
SoundFile arwPull;
SoundFile popSound;
SoundFile buttonPress;
// Declare PImage objects for background images and character image
PImage bckg1;
PImage bckg2;
PImage bckgStart;
PImage transition;
PImage arc;
// Declare objects
Archer archer;
Level level;
Score score;
Balloon b;
Balloon bY;
Arrow arrow;
ArrayList<Balloon> balloons; // for red ballonons
ArrayList<Balloon> Yballoons; // for yellow balloons
ArrayList<Arrow> arrows;
// Declare variables
int quiver = 20;
String s4 = "CONGRATS!!";
int score1;
int score2;
boolean  isYellow;
float acceleration;
boolean flag;
boolean gameStart = false;
boolean transitionClicked = false;

// Setup function: initializes variables, loads images and sounds
void setup() {
  size(800, 600);
  // Load background images
  bckg1 = loadImage("imgs/backgrounds/background1.jpg");
  bckg2 = loadImage("imgs/backgrounds/background222.jpg");
  bckgStart = loadImage("imgs/backgrounds/intro-01.jpg");
  transition = loadImage("imgs/backgrounds/Continue -02-01.jpg");
  arc = loadImage("imgs/chars/arcccher_boy2-01.png");
  // Load sound files
  arwSound = new SoundFile(this, "sounds/arrow-impact-87260.mp3");
  arwPull = new SoundFile(this, "sounds/arrowpull2.mp3");
  popSound = new SoundFile(this, "sounds/balloon-pop-48030.mp3");
  buttonPress = new SoundFile(this, "sounds/click-button-140881.mp3");
  // Initialize objects
  archer = new Archer();
  level = new Level(1); // Start from level 1
  score = new Score(quiver, 0);
  balloons = new ArrayList<Balloon>();
  Yballoons = new ArrayList<Balloon>();
  arrows = new ArrayList<Arrow>();
}
void draw() {
  // Check if the game has started
  if (!gameStart) {
    image(bckgStart, 0, 0);
    // Check if the start game button is clicked
    if (mouseX > 305 && mouseX < 505 && mouseY < 190  && mouseY > 118 && mousePressed) {
      gameStart = true;
      buttonPress.play();
      resetLevel();
    }
  } else {
    score2 = score1 + score.calculateScore(); // accumulating score
    // Display score, level number, and remaining arrows
    if (level.levelNumber == 1) {
      image(bckg1, 0, 0);
      textSize(25);
      fill(40, 0, 13);
      text(score.calculateScore(), 75, 52 );
      textSize(25);
      fill(40, 0, 13);
      text(score.shotBalloons, 720, 57);
      textSize(25);
      fill(40, 0, 13);
      text(quiver, 720, 125);
    } else if (level.levelNumber == 2) {
      image(bckg2, 0, 0); // Theme changing
      textSize(25);
      fill(40, 0, 13);
      text(score2, 75, 52 );
      textSize(25);
      fill(40, 0, 13);
      text(score.shotBalloons, 720, 57);
      textSize(25);
      fill(40, 0, 13);
      text(quiver, 720, 125);
    }
    archer.display(); //draw the character
    for (Balloon b : balloons) {  // Draw and move red balloons for both levels
      b.display();
      b.move();
    }
    if (level.levelNumber == 2) {
      for (Balloon bY : Yballoons) {  // Draw and move yellow balloons in level 2
        bY.display();
        bY.move();
      }
    }
    // Draw and move arrows
    for (int i = arrows.size() - 1; i >= 0; i--) {
      arrow = arrows.get(i);
      arrow.display();
      arrow.move();
      if (arrow.offScreen()) {
        arrows.remove(i);
      }
    }
    // Check for collisions and update score for RED balloons
    for (int j = balloons.size() - 1; j >= 0; j--) {
      b = balloons.get(j);
      for (Arrow arw : arrows) {
        if (b.hit(arw)) {
          popSound.play();
          balloons.remove(j);
          score.shotBalloons++;
          break;
        }
      }
    }
    // Check for collisions and update score for YELLOW balloons
    if (level.levelNumber == 2) {
      for (int k = Yballoons.size() - 1; k >= 0; k--) {
        bY = Yballoons.get(k);
        for (Arrow arw : arrows) {
          if (bY.hit(arw)) {
            popSound.play();
            Yballoons.remove(k);
            score.shotBalloons++;
            break;
          }
        }
      }
    }
    //chcek level 2 completed and show CONGRATS
    if (level.levelNumber == 2 && level.isLevelCompleted()) {
      fill (0, 0, 20);
      textSize(40);
      text(s4, (width/2)-80, height/2);
      // remove remaining yellow balloons and quiver if exist
      Yballoons.clear();
      quiver = 0;
      arrows.clear();
    }
    // check if level 1 completed and go to the next level
    if (level.levelNumber == 1 && level.isLevelCompleted() && !transitionClicked /*&& !gameLost*/) {
      image(transition, 0, 0);
      if (mouseX > 320 && mouseX < 500 && mouseY < 387  && mouseY > 333 && mousePressed) // check if level2 button is pressed
      {
        transitionClicked = true;
        arwPull.stop();
        arwSound.stop();
        buttonPress.play();
        score1 = score.calculateScore(); // store the score of level 1
        level.levelNumber++;
        quiver = 20; // fill quiver
        score.remainingArrows = quiver;
        score.shotBalloons = 0;
        arrows.clear();
        resetLevel();
      }
    }
  }
}
// end of draw

// Reset level function: initializes balloons for each level
void resetLevel() {
  balloons.clear();
  Yballoons.clear();
  //initial  positions
  float startX = width - 30;
  float startY = height - 40;
  if (level.levelNumber == 1) {
    // Level 1:  15 red balloons aligned next to each other
    for (int i = 0; i < 15; i++) {
      balloons.add(new Balloon(startX - i * 30, startY, false, 0)); // fill balloons
    }
  }
  //level2 : 3 yellow balloons and 15 red balloons with random positions
  else if (level.levelNumber == 2) {
    for (int i = 0; i < 15; i++) { // Red Balloons
      balloons.add(new Balloon (startX - i * 30, random(height), false, 0) );
    }
    for (int j = 0; j < 3; j++) {  // Yellow Balloons
      isYellow = j < 3;
      acceleration = j < 3 ? random(.0005, .00051):0; // random acceleration for tricky balloons
      Yballoons.add(new Balloon (random(width-430, width-150), random(height), isYellow, acceleration) );
    }
  }
}

// mouse Controls
void mouseMoved() {
  archer.update(mouseY);
}
void mousePressed() {
  //Arrow reloading
  if (mouseButton == RIGHT && quiver > 0 && gameStart && !level.isLevelCompleted()) {
    arc = loadImage("imgs/chars/arrrcher_boy-01.png");
    arwPull.play();
    flag = true;
  }
  // Arrow shooting
  if (mouseButton == LEFT && flag && gameStart && !level.isLevelCompleted()) {
    arc = loadImage("imgs/chars/arcccher_boy2-01.png");
    if (quiver > 0) {
      arrows.add(archer.shoot());
      arwSound.play();
      arwPull.stop();
      quiver--;
      score.remainingArrows = quiver;
      flag = false; // preventing random shooting
    }
  }
  // Try Again when you loose using Right click
  else if (mouseButton == RIGHT && quiver == 0) {
    if (level.levelNumber == 1 && !balloons.isEmpty()) {
      quiver = 20;
      score.shotBalloons =0;
      resetLevel();
    } else if (level.levelNumber == 2 && !balloons.isEmpty()) { // check for just the red balloons
      quiver = 20;
      score.shotBalloons =0;
      resetLevel();  // resetting the same level with the previous level score
    }
  }
}
