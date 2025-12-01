/**
 * 2025/10/19
 * 分别取两个二进制字符串的某一位
 * 然后作逻辑运算
 * 所用二进制字符串取自v位递增二进制数字
 */

int w = 1;
int h = 1;
int aX = 0;
int aY = 0;
String StringX = "";
String StringY = "";
int c = 0;
int mX;
int mY;
int v = 6;
void setup() {
  size(500,500);
  for (int i = 0; i < int(pow(2, v)); i++) {
    String s1 = Integer.toString(i, 2);
    while (s1.length() < v) {
      s1 = "0" + s1;
    }
    StringX += s1;
  }
  StringY = StringX;
  mX = StringX.length();
  mY = StringY.length();
  noStroke();
  println(StringX);
  noLoop();
}
void draw() {
  for (int x = 0; x < width / w; x++) {
    for (int y = 0;y < height / h; y++) {
      fill(calculate(x, y));
      rect(x*w, y*h, w, h);
    }
  }
}
void keyPressed() {
  switch(key) {
    case '1':
      c = 1;
      redraw();
      break;
    case '2':
      c = 2;
      redraw();
      break;
    case '0':
      c = 0;
      redraw();
      break;
  }
}
int calculate(int x, int y) {
  int x1 = Integer.valueOf(StringX.charAt(x % mX)-48);
  int y1 = Integer.valueOf(StringY.charAt(y % mY)-48);
  int a=0;
  if (c == 0) {
    a=x1&y1;
  } else if (c==1) {
    a=x1|y1;
  } else if (c==2) {
    a = x1^y1;
  }
  return a*255;
}
