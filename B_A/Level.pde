// Level Class
class Level {
  int levelNumber;

  Level(int levelNumber) {
    this.levelNumber = levelNumber;
  }

  boolean isLevelCompleted() {
    return balloons.isEmpty(); // Red balloons only
  }
}
