// Score Class
class Score {
  int remainingArrows;
  int shotBalloons;

  Score(int remainingArrows, int shotBalloons) {
    this.remainingArrows = remainingArrows;
    this.shotBalloons = shotBalloons;
  }
  int calculateScore() {
    // Score equation ordered by professor
    return (remainingArrows + 1) * shotBalloons;
  }
}
