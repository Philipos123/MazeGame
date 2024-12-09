class Obstacle {
  // Variables
  int x;
  int y;
  int w;
  int h;

  int left;
  int right; 
  int top;
  int bottom;

  // Constructor
  Obstacle(int startingX, int startingY, int startingW, int startingH) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;

    // Define boundaries
    left = x - w / 2;
    right = x + w / 2;
    top = y - h / 2;
    bottom = y + h / 2;
  }

  // Render the obstacle
  void render() {
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  // Check for collision with player
  void playerCollide(Player aPlayer) {
    // Adjusted boundaries to account for sensitivity
    int adjustedLeft = left + 2;   // Add tolerance
    int adjustedRight = right - 2; 
    int adjustedTop = top + 2;
    int adjustedBottom = bottom - 2;

    // Check if the player is colliding from the left
    if (aPlayer.top <= adjustedBottom &&
        aPlayer.bottom >= adjustedTop &&
        aPlayer.right >= adjustedLeft &&
        aPlayer.left <= left) {
      aPlayer.isMovingRight = false;
      aPlayer.x = left - aPlayer.w / 2;
      aPlayer.gameOver = true;
    }

    // Check if the player is colliding from the right
    if (aPlayer.top <= adjustedBottom &&
        aPlayer.bottom >= adjustedTop &&
        aPlayer.left < adjustedRight &&
        aPlayer.right >= right) {
      aPlayer.isMovingLeft = false;
      aPlayer.x = right + aPlayer.w / 2;
      aPlayer.gameOver = true;
    }

    // Check if the player is colliding from the top
    if (aPlayer.left <= adjustedRight &&
        aPlayer.right >= adjustedLeft &&
        aPlayer.bottom > adjustedTop &&
        aPlayer.top <= top) {
      aPlayer.isMovingDown = false;
      aPlayer.y = top - aPlayer.h / 2;
      aPlayer.gameOver = true;
    }

    // Check if the player is colliding from the bottom
    if (aPlayer.left <= adjustedRight &&
        aPlayer.right >= adjustedLeft &&
        aPlayer.top < adjustedBottom &&
        aPlayer.bottom >= bottom) {
      aPlayer.isMovingUp = false;
      aPlayer.y = bottom + aPlayer.h / 2;
      aPlayer.gameOver = true;
    }
  }
}
