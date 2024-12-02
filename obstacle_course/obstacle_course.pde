float xball = 200;   // ball's x position
float yball;        // ball's y position (starts at the bottom)

float ballSize = 20;  // size of the ball
float xSpeedball = 0;  // horizontal speed of the ball
float ySpeedball = 0;  // virtical speed of the ball

float forwardSpeed = 3; // forward movement
float gapWidth = 350; // gap between the pipes

float pipeHeight = 60; // pipe thickness
float TopSpeed = 5; //the top speed you can move 

boolean gamePaused = false; // boolean for pausing the game

float topOfBall; //capture the top of the ball
float bottomOfBall;  //capture the bottom of the ball
float topOfPipe; //for calculating top of pipe later
float bottomOfPipe; //for calculating bottom of pipe  later
float leftOfBall;
float rightOfBall; 
float leftOfGap;  
float rightOfGap; 
float leftpipewidth;

float startRightPipex;
float startRightPipey;
float rightPipeWidth;

//position of the pipes
float[] pipeY = new float[3];
float[] pipeX = new float[3];

boolean isGameOver = false;
int score = 0;

void setup() {
  size(800, 400);
  yball = height - ballSize / 2; //ball starts at bottom
  gameReset();
}

void draw() {
  
  background(135, 206, 235); 


  if (gamePaused) {
    fill(255);
    textSize(32);
    text("Paused", width / 2 - 50, height / 2);
    return;
  }

  if (isGameOver) {
    fill(255, 0, 0);
    textSize(32);
    text("Trial Over", width / 2 - 80, height / 2);
    textSize(16);
    text("press r to restart ", width / 2 - 70, height / 2 + 30);
    return;
  }




  // Move pipes based on forwardSpeed
  for (int i = 0; i < pipeY.length; i++) {
    pipeY[i] += forwardSpeed;

    // Reset pipe if it goes offscreen
    if (pipeY[i] > height) {
      pipeY[i] = -pipeHeight;
      pipeX[i] = random(gapWidth / 2, width - gapWidth / 2);
      score++;
    }
  }


  // Update ball position
  xball += xSpeedball;
  yball += ySpeedball;
  
   // draw the ball
  fill(255, 255, 0);
  ellipse(xball, yball, ballSize, ballSize);
  
  // Draw pipes
  for (int i = 0; i < pipeY.length; i++) {
    fill(0, 255, 0);
    
    leftpipewidth =  pipeX[i] -  gapWidth / 2;
    startRightPipex = pipeX[i]  +  gapWidth / 2;
    startRightPipey= pipeY[i];
    rightPipeWidth = width - startRightPipex;
    
    rect(0,  pipeY[i],  leftpipewidth,  pipeHeight); // left part of the pipe
    
    rect( startRightPipex,startRightPipey,  startRightPipex, pipeHeight); //right part of the pipe
  }



  // check to see if collided
  for (int i = 0; i < pipeY.length; i++) {
    
    //bad hit detection!   
    topOfBall = yball +  ballSize /2; 
    bottomOfBall= yball -  ballSize /2; 
    topOfPipe = pipeY[i];    
    bottomOfPipe = pipeY[i] +pipeHeight;
    leftOfBall = xball - ballSize / 2;
    rightOfBall = xball + ballSize / 2;
    leftOfGap = pipeX[i] - gapWidth / 2;
    rightOfGap = pipeX[i] + gapWidth / 2;
    
    if (topOfBall > topOfPipe && bottomOfBall < bottomOfPipe) {
      
      if (leftOfBall < leftOfGap || rightOfBall > rightOfGap) {
        
        isGameOver = true;
        
      }
    }
  }

  // show the score
  fill(0);
  textSize(24);
  text("Score: " + score, 10, 30);

  // stay within the bounds
  if (xball < 0 || xball > width || yball < 0 || yball > height) {
    isGameOver = true;
  }
}


void keyReleased() {
  
     // try to unpause if down is pressed again
  if (keyCode == DOWN) {
    gamePaused = false;
  }
  //  stop horizontal movement if keys are pressed 
  if (keyCode == LEFT || keyCode == RIGHT) {
    xSpeedball = 0;
  }


}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    gameReset();
  }

  
  if (keyCode == LEFT) {
    xSpeedball = -TopSpeed;   //  left
  }
  else if (keyCode == RIGHT) {
    xSpeedball = TopSpeed;   // right
  } 
  else if (keyCode == UP) {
    forwardSpeed += 0.5; // speedup if up is pressed
    if (forwardSpeed > TopSpeed) forwardSpeed = TopSpeed;
  } 
  else if (keyCode == DOWN) {
    forwardSpeed = 0; // try to stop altogether 
    xSpeedball = 0;   // stop horizontal
    ySpeedball = 0;   // stop vertical movement
    gamePaused = true; // not proud but it works
  }
}

void gameReset() {
  xball = width / 2;
  yball = height - ballSize / 2; // Reset to bottom of the screen
  xSpeedball = 0;
  ySpeedball = 0;
  
  forwardSpeed = 3; // Reset speed
  isGameOver = false;
  
  gamePaused = false;
  score = 0;

  for (int i = 0; i < pipeY.length; i++) {
    pipeY[i] = -i * (height / pipeY.length);
    pipeX[i] = random(gapWidth / 2, width - gapWidth / 2);
  }
}
