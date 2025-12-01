/**
 * 2025/10/19
 */

int w = 10;
int h = 10;
int mX = 6;
int mY = 6;
int aX = 0;
int aY = 0;
String StringX = "000001";
String StringY = "000001";
void setup() {
  size(300,300);
  noStroke();
  println(StringX.charAt(0));
  noLoop();
}
void draw() {
  for (int x = 0; x < width / w; x++) {
    for (int y = 0;y < height / h; y++) {
      println(x,y,calculate(x, y));
      fill(calculate(x, y));
      rect(x*w, y*h, w, h);
    }
  }
}
int calculate(int x, int y) {
  int x1 = Integer.valueOf(StringX.charAt(x % mX)-48);
  int y1 = Integer.valueOf(StringY.charAt(y % mY)-48);
  return (x1*y1)*255;
}
