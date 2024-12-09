
import processing.sound.*;
PImage mazeImage; 
PImage welcomeImage;
PImage gameOverImage;
PImage wonImage;
Player p1, p2; 

SoundFile bgMusic;
SoundFile moveSound;
ArrayList<Obstacle> obstacleList;
int gameState;
String difficulty = "Easy";


void setup() {
  size(1000, 800);
  mazeImage = loadImage("Maze.jpg");
  welcomeImage = loadImage("welcome.jpg"); 
  gameOverImage = loadImage("oops.jpg"); 
  wonImage = loadImage("won.jpg"); 
  
 
  
 bgMusic = new SoundFile(this, "background.wav"); 
 moveSound = new SoundFile(this, "move.wav");
 bgMusic.loop();
  
 
 // Initialize the obstacle list and maze structure
 obstacleList = new ArrayList <Obstacle>();
 initializeGame(); 
}


void initializeGame() {
  p1 = new Player(width / 20, height - 15, 50, 50); 
  p2 = new Player(width - 50, 250, 50, 50);      
  gameState = 0; 
  setDifficulty();
}

void draw() {
  background(42); 
  switch (gameState) {
    case 0:  
      displayStartScreen();
      break;
    case 1:  
      image(mazeImage, 0, 0, width, height);
      executeGame();
      break;
    case 2: 
      displayEndScreen();
      break;
    case 4:  
      displayGameOverScreen();
      break;
  }

  if (gameState == 1) {
    for (Obstacle anObstacle : obstacleList) {
      anObstacle.render();
      anObstacle.playerCollide(p1);  
    }
    if (p1.gameOver) {
      gameState = 4;
    }
  }
}

void displayStartScreen() {
  background(42);  
  image(welcomeImage, 0, 0, width, height);  
  textAlign(CENTER, CENTER);
  textSize(100);
  fill(255);
  text("Press 'R' to Start", width / 2, height - 50);
}

void displayGameOverScreen() {
  background(42);  
  image(gameOverImage, 0, 0, width, height); 
  textAlign(CENTER, CENTER);
  textSize(48);
  fill(255, 0, 0);
  textSize(70);
  fill(255);
  text("Press 'R' to Restart", width / 2, height / 1.5);
}

void displayEndScreen() {
  background(42);  
  image(wonImage, 0, 0, width, height);  
  textAlign(CENTER, CENTER);
  textSize(100);
  fill(255);
  text("Press 'R' to Start", width / 2, height - 50);
}
void executeGame() {
  p1.render(); 
  p1.move(); 
  p2.render(); 
  
  // Check if Player 1 reaches Player 2
  if (checkCollision(p1, p2)) {
    advanceLevel(); 
  }
}

// Function to check collision between Player 1 and Player 2
boolean checkCollision(Player a, Player b) {
  return (a.x < b.x + b.w && a.x + a.w > b.x &&
          a.y < b.y + b.h && a.y + a.h > b.y);
}


void keyPressed() {
  if (gameState == 0 && (key == 'r' || key == 'R')) {
    gameState = 1;  // Start game
  } else if (gameState == 4 && (key == 'r' || key == 'R')) {
    initializeGame();  
    gameState = 1;     
  } else if (gameState == 1) {
    if (keyCode == LEFT) {
      p1.isMovingLeft = true;
    }
    if (keyCode == RIGHT) {
      p1.isMovingRight = true;
    }
    if (keyCode == UP) {
      p1.isMovingUp = true;
    }
    if (keyCode == DOWN) {
      p1.isMovingDown = true;
    }
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    p1.isMovingLeft = false;
  }
  if (keyCode == RIGHT) {
    p1.isMovingRight = false;
  }
  if (keyCode == UP) {
    p1.isMovingUp = false;
  }
  if (keyCode == DOWN) {
    p1.isMovingDown = false;
  }
}

void playMoveSound() {
 moveSound.play();
}


void setDifficulty() {
  obstacleList.clear();
  switch (difficulty) {
    case "Easy":
      p1.speed = 10;
      obstacleList.clear();

      // Outer boundaries
  obstacleList.add(new Obstacle(5, 600, 10, 1200));   // Left 1
  obstacleList.add(new Obstacle(400, 6, 10000, 10)); // Top 2
  obstacleList.add(new Obstacle(590, 790, 1000, 10)); // Bottom 3
  obstacleList.add(new Obstacle(995, 10, 10, 1600)); // Right 4


  obstacleList.add(new Obstacle(50, 500, 400, 10));
  obstacleList.add(new Obstacle(245, 430, 10, 150)); // crosse 
  obstacleList.add(new Obstacle(250, 350, 200, 10));
  obstacleList.add(new Obstacle(245, 720, 10, 150)); // crosse 
  obstacleList.add(new Obstacle(50, 570, 400, 10));
  obstacleList.add(new Obstacle(150, 620, 10, 100)); // crosse 
  obstacleList.add(new Obstacle(650, 650, 300, 10));
  obstacleList.add(new Obstacle(795, 700, 10, 100)); // crosse
  obstacleList.add(new Obstacle(450, 510, 100, 10));
  obstacleList.add(new Obstacle(500, 580, 10, 150)); // crosse  
  obstacleList.add(new Obstacle(590, 250, 170, 10));
  obstacleList.add(new Obstacle(500, 200, 10, 400)); // crosse 
   
  
 obstacleList.add(new Obstacle(400, 210, 200, 10));
 obstacleList.add(new Obstacle(180, 150, 170, 10));
 obstacleList.add(new Obstacle(100, 150, 10, 300)); // crosse 
 obstacleList.add(new Obstacle(900, 400, 200, 10));
 obstacleList.add(new Obstacle(800, 100, 10, 200)); // crosse 
 obstacleList.add(new Obstacle(800, 445, 10, 100)); // crosse 
 obstacleList.add(new Obstacle(755, 500, 100, 10));
 obstacleList.add(new Obstacle(700, 455, 10, 100)); // crosse 
 obstacleList.add(new Obstacle(900, 250, 10, 300)); // crosse
 obstacleList.add(new Obstacle(820, 300, 150, 10));
 obstacleList.add(new Obstacle(400, 550, 10, 200)); // crosse 
 break;
      
      
      
      
      case "Medium":
      p1.speed = 10;
      obstacleList.clear();
      p2.x = width - 950; 
      p2.y = 70;
   // Define boundaries
obstacleList.add(new Obstacle(5, 600, 10, 1200));   // Left 1
obstacleList.add(new Obstacle(400, 6, 10000, 10)); // Top 2
obstacleList.add(new Obstacle(590, 790, 1000, 10)); // Bottom 3
obstacleList.add(new Obstacle(995, 10, 10, 1600)); // Right 4

obstacleList.add(new Obstacle(400, 200, 10, 100)); 
obstacleList.add(new Obstacle(100, 50, 10, 200)); 
obstacleList.add(new Obstacle(170, 100, 150, 10)); 
obstacleList.add(new Obstacle(300, 300, 200, 10)); 
obstacleList.add(new Obstacle(500, 220, 10, 300)); 
obstacleList.add(new Obstacle(700, 100, 10, 200)); 
obstacleList.add(new Obstacle(600, 300, 200, 10)); 
obstacleList.add(new Obstacle(850, 200, 10, 200)); 
obstacleList.add(new Obstacle(450, 500, 200, 10)); 
obstacleList.add(new Obstacle(100, 500, 10, 200)); 
obstacleList.add(new Obstacle(200, 600, 200, 10));



obstacleList.add(new Obstacle(600, 500, 10, 100)); 
obstacleList.add(new Obstacle(850, 400, 100, 10)); 
obstacleList.add(new Obstacle(600, 700, 10, 100));
obstacleList.add(new Obstacle(600, 400, 10, 200)); 
obstacleList.add(new Obstacle(200, 700, 200, 10)); 
obstacleList.add(new Obstacle(800, 500, 100, 10)); 
obstacleList.add(new Obstacle(100, 300, 200, 10)); 
obstacleList.add(new Obstacle(400, 300, 10, 100)); 
obstacleList.add(new Obstacle(750, 500, 10, 200));


obstacleList.add(new Obstacle(450, 710, 10, 150)); 
obstacleList.add(new Obstacle(350, 455, 10, 100)); 
obstacleList.add(new Obstacle(850, 600, 100, 10)); 
obstacleList.add(new Obstacle(150, 200, 100, 10)); 
obstacleList.add(new Obstacle(200, 400, 10, 200)); 
obstacleList.add(new Obstacle(300, 700, 10, 200)); 
obstacleList.add(new Obstacle(900, 700, 600, 10)); 
obstacleList.add(new Obstacle(845, 600, 200, 10));
  
obstacleList.add(new Obstacle(845, 400, 200, 10));
obstacleList.add(new Obstacle(845, 100, 100, 10));
obstacleList.add(new Obstacle(770, 300, 170, 10));
obstacleList.add(new Obstacle(600, 250, 10, 100));
obstacleList.add(new Obstacle(800, 120, 10, 100)); 
obstacleList.add(new Obstacle(450, 350, 110, 10));
obstacleList.add(new Obstacle(300, 50, 10, 300)); // crosse 
obstacleList.add(new Obstacle(370, 600, 10, 200)); // crosse 
break;
    
       
       case "Hard":
        p1.speed = 7;
// Boundary walls
  obstacleList.add(new Obstacle(5, 600, 10, 1200));   // Left 1
  obstacleList.add(new Obstacle(400, 6, 10000, 10)); // Top 2
  obstacleList.add(new Obstacle(590, 790, 1000, 10)); // Bottom 3
  obstacleList.add(new Obstacle(995, 10, 10, 1600)); // Right 4
  
  // Initial maze walls
  obstacleList.add(new Obstacle(2, 10, 10, 100));  
  obstacleList.add(new Obstacle(50, 55, 100, 10)); 
  obstacleList.add(new Obstacle(95, 340, 10, 140));
  obstacleList.add(new Obstacle(15, 600, 120, 10));
  obstacleList.add(new Obstacle(300, 100, 150, 10));
  obstacleList.add(new Obstacle(530, 100, 170, 10));
  obstacleList.add(new Obstacle(450, 113, 10, 35)); // crosse
   
   

 obstacleList.add(new Obstacle(300, 50, 10, 90)); // crosse
 obstacleList.add(new Obstacle(50, 415, 100, 10)); 
 obstacleList.add(new Obstacle(830, 100, 150, 10));
 obstacleList.add(new Obstacle(610, 200, 10, 200)); // crosse
 obstacleList.add(new Obstacle(570, 170, 80, 10));
 obstacleList.add(new Obstacle(750, 130, 10, 70)); // crosse
 obstacleList.add(new Obstacle(650, 220, 80, 10));
 obstacleList.add(new Obstacle(785, 170, 80, 10));  
 obstacleList.add(new Obstacle(820, 370, 10, 400)); // crosse
   
  
  
  
 obstacleList.add(new Obstacle(710, 300, 210, 10));
 obstacleList.add(new Obstacle(900, 200, 10, 200)); // crosse
 obstacleList.add(new Obstacle(950, 300, 110, 10));
 obstacleList.add(new Obstacle(950, 370, 100, 10));
 obstacleList.add(new Obstacle(850, 570, 70, 10));
 obstacleList.add(new Obstacle(950, 500, 100, 10));// 
 obstacleList.add(new Obstacle(900, 435, 10, 140)); // crosse
 obstacleList.add(new Obstacle(950, 650, 250, 10));
 obstacleList.add(new Obstacle(900, 690, 10, 80)); // crosse
 obstacleList.add(new Obstacle(830, 690, 10, 80)); // crosse
 obstacleList.add(new Obstacle(725, 720, 10, 125)); // crosse
 obstacleList.add(new Obstacle(790, 400, 70, 10));
 obstacleList.add(new Obstacle(690, 570, 70, 10));
   
   
  
   // Additional vertical walls
obstacleList.add(new Obstacle(370, 150, 10, 100));
obstacleList.add(new Obstacle(195, 295, 10, 250));
obstacleList.add(new Obstacle(150, 170, 100, 10));
obstacleList.add(new Obstacle(310, 200, 240, 10)); 
obstacleList.add(new Obstacle(430, 245, 10, 100)); // crosse   
obstacleList.add(new Obstacle(280, 300, 170, 10));
obstacleList.add(new Obstacle(360, 350, 10, 100)); // crosse 
obstacleList.add(new Obstacle(410, 400, 110, 10));
obstacleList.add(new Obstacle(460, 440, 10, 80)); // crosse   
obstacleList.add(new Obstacle(505, 480, 100, 10));
obstacleList.add(new Obstacle(650, 530, 10, 250)); // crosse
obstacleList.add(new Obstacle(425, 570, 80, 10));
obstacleList.add(new Obstacle(460, 610, 10, 80)); // crosse 
obstacleList.add(new Obstacle(410, 650, 110, 10));
obstacleList.add(new Obstacle(360, 680, 10, 70)); // crosse
   
obstacleList.add(new Obstacle(410, 710, 110, 10));
obstacleList.add(new Obstacle(460, 750, 10, 80)); // crosse
obstacleList.add(new Obstacle(200, 710, 130, 10));  
obstacleList.add(new Obstacle(200, 750, 10, 80)); // crosse
obstacleList.add(new Obstacle(230, 650, 90, 10));
obstacleList.add(new Obstacle(270, 680, 10, 70)); // crosse
obstacleList.add(new Obstacle(190, 630, 10, 50)); // crosse
obstacleList.add(new Obstacle(140, 680, 10, 70)); // crosse
obstacleList.add(new Obstacle(550, 750, 10, 80)); // crosse
obstacleList.add(new Obstacle(230, 415, 70, 10)); 
obstacleList.add(new Obstacle(260, 490, 10, 150));//crosse
obstacleList.add(new Obstacle(210, 515, 230, 10)); 
obstacleList.add(new Obstacle(320, 540, 10, 50)); // crosse 
obstacleList.add(new Obstacle(600, 400, 110, 10));
obstacleList.add(new Obstacle(550, 440, 10, 80)); // crosse 
obstacleList.add(new Obstacle(600, 520, 10, 250)); // crosse
obstacleList.add(new Obstacle(480, 300, 110, 10));
//obstacleList.add(new Obstacle(690, 55, 10, 100)); // crosse 
break;
   }
}

void advanceLevel() {
  if (difficulty.equals("Easy")) {
    difficulty = "Medium";
  } else if (difficulty.equals("Medium")) {
    difficulty = "Hard";
  } else if (difficulty.equals("Hard")) {
    gameState = 2; 
    return;
  }
  initializeGame(); 
  gameState = 1; 
}
