class Carrion {
  // State
  final int COLOR = 0xFF832222;
  int x;
  int y;

  // Behaviour
  Carrion() {
    do {
      x = (int) random(field.width);
      y = (int) random(field.height);
    } while (snake.isColliding(x, y));
  }

  boolean isColliding(int x, int y) {
    return this.x == x && this.y == y;
  }

  void draw() {
    stroke(0);
    fill(COLOR);

    int pixelX = centeringShiftX + x * cellPixelSize;
    int pixelY = centeringShiftY + y * cellPixelSize;
    rect(pixelX, pixelY, cellPixelSize, cellPixelSize);
  }
}
