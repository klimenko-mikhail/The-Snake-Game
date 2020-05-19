final int MENU_STATE = 0;
final int GAME_STATE = 1;
final int PAUSED_STATE = 2;
final int VICTORY_STATE = 3;
final int DEFEAT_STATE = 4;

int currentState = MENU_STATE;

Field field = new Field(48, 48);
Snake snake = new Snake(field, 0, 0, 1, 0);
Carrion carrion = new Carrion();

void setup() {
  fullScreen();
  background(0);

  recalcDrawingSizes();
}

void draw() {
  background(0);

  switch (currentState) {
  case MENU_STATE:
    drawMenu();
    break;
  case GAME_STATE:
    drawGame();
    break;
  case PAUSED_STATE:
    drawPause();
    break;
  case VICTORY_STATE:
    drawVictory();
    break;
  }
  delay(100);
}

void drawMenu() {
  fill(255, 0, 0);
  textSize(60);
  textAlign(CENTER, CENTER);
  text("Snake Game", width / 2, height / 2);

  fill(255);
  textSize(40);
  text("Press Enter to start the game", width / 2, height / 2 + 100);
}

void drawGame() {
  field.draw();
  carrion.draw();
  snake.draw();
  snake.drawScore();

  snake.move();
}

void drawPause() {
  textAlign(CENTER, CENTER);

  fill(255);
  textSize(40);
  text("Press P to continue the game", width / 2, height / 2);
}

float angle = 0.0004;
void drawVictory() { 
  noStroke();
  pushMatrix();
  translate(width / 2, height / 2);
  for (int i = 0; i < 100; i++) {
    rotate(angle);
    angle += 0.00005;
    translate(i * 10, 0);
    fill(200 * i / 100.0);
    rect(0, 0, 100, 100);
  }
  popMatrix();

  // TODO

  fill(255, 0, 0);
  textSize(60);
  textAlign(CENTER, CENTER);
  text("You are Victory!", width / 2, height / 2);

  textSize(50);
  text("Your Score " + snake.score, width / 2, height / 2 + 100);

  fill(255);
  textSize(40);
  text("Press Enter to go back to menu", width / 2, height / 2 + 200);
}

void drawDefeat() {
  noStroke();
  pushMatrix();
  translate(width / 2, height / 2);
  for (int i = 0; i < 100; i++) {
    rotate(angle);
    angle += 0.00005;
    translate(i * 10, 0);
    fill(200 * i / 100.0);
    rect(0, 0, 100, 100);
  }
  popMatrix();

  // TODO

  fill(255, 0, 0);
  textSize(60);
  textAlign(CENTER, CENTER);
  text("You are Defeat!", width / 2, height / 2);

  textSize(50);
  text("Your Score " + snake.score, width / 2, height / 2 + 100);

  fill(255);
  textSize(40);
  text("Press Enter to go back to menu", width / 2, height / 2 + 200);
}

void keyPressed() {
  switch (currentState) {
  case MENU_STATE:
    keyPressedInMenu();
    break;
  case GAME_STATE:
    keyPressedInGame();
    break;
  case PAUSED_STATE:
    keyPressedOnPause();
    break;
  case VICTORY_STATE:
    keyPressedInVictory();
    break;
  case DEFEAT_STATE:
    keyPressedInDefeat();
    break;
  }
}

void keyPressedInMenu() {
  if (keyCode == ENTER) {
    currentState = GAME_STATE;
  }
}

void keyPressedInGame() {
  switch (key) {
  case 'w':
  case 'W':
    snake.turnUp();
    break;
  case 's':
  case 'S':
    snake.turnDown();
    break;
  case 'a':
  case 'A':
    snake.turnLeft();
    break;
  case 'd':
  case 'D':
    snake.turnRight();
    break;
  case 'p':
  case 'P':
    currentState = PAUSED_STATE;
    break;
  }
}

void keyPressedOnPause() {
  if (keyCode == 'P') {
    currentState = GAME_STATE;
  }
}

void keyPressedInVictory() {
  if (keyCode == ENTER) {
    currentState = MENU_STATE;
  }
  if (snake.score == 2) {
    currentState = VICTORY_STATE;
    drawVictory();
  }
}

void keyPressedInDefeat() {
  if (keyCode == ENTER) {
    currentState = MENU_STATE;
  }
  if (snake.alive == false) {
    currentState = DEFEAT_STATE; 
    drawDefeat();
  }
}
