// Player class
class Player {
  int x;
  int y;
  int w;
  int h;
  boolean isMovingLeft;
  boolean isMovingRight;
  boolean isMovingUp;
  boolean isMovingDown;
  int speed;
  boolean gameOver;

int left;
int right; 
int  top;
int bottom;


  // Constructor
  Player(int startingX, int startingY, int startingW, int startingH) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;
    speed = 10;
     gameOver = false;
    
  left= x -w/2;
  right= x+w/2;
  top= y- h/2;
  bottom = y+h/2;
  }


 void render() {
    if (!gameOver) { 
      fill(255, 0, 0);
      noStroke();
      circle(x, y, 15);
      
      fill(255, 255, 255);
      noStroke();
      circle(x, y, 15);

      
    }
  }
  
  void move() {
    if (gameOver) return;

    left = x - w / 2;
    right = x + w / 2;
    top = y - h / 2;
    bottom = y + h / 2;

    if (isMovingLeft && left > 0) {
      x -= speed;
    }

    if (isMovingRight && right < width) {
      x += speed;
    }

    if (isMovingUp && top > 0) {
      y -= speed;
    }

    if (isMovingDown && bottom < height) {
      y += speed;
    }
  }
}
