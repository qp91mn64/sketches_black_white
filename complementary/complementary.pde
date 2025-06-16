/**
 黑和白的舞蹈
 
 互补
 
 最开始1对应黑色0对应白色。
 如果1对应白色0对应黑色，那么画出的每个像素点的颜色恰好翻转。
 如果数值到颜色的映射对应的二进制数字按位取反，那么每个像素点的颜色还是恰好翻转。
 在没有空格子的地方，二进制按位取反与交换0、1颜色效果相同。

 新增键盘控制：
 按下数字1键按位取反
 按下数字2键交换0、1颜色
 查看控制台的信息和视觉效果的变化
 比较两种不同方式是否有差异
 */
int cellWidth = 1;
int cellHeight = 1;
int d = 0;
int b = 0;
int maxNumber = 16;  // 最大数位数
int distance = maxNumber;  // 相邻两列之间距离
int base = 2;  // 进制，似乎最多只能支持36进制，基数更大会按照十进制处理
int offset = 0;  // 数值从这里开始一帧加1
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset;  // 当前图上对应数值最大值
int[] colors1 = new int[base];  // 对应颜色数组
String s;  //把十进制数值转换成指定进制字符串
String frameName;  // 保存的图片名称
String color1 = "10";  // 颜色对应的字符串，这里最左边是最大的数字对应的颜色，最右边是0对应的颜色
boolean r = true;
int c = 0;
color c0 = 255;  // 0对应白色
color c1 = 0;  // 1对应黑色
color backgroundColor = 255;
void setup() {
  smooth();
  noStroke();
  size(400, 800);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  for (int a = 0; a < base; a++) {
    char c1 = color1.charAt(base - a - 1);
    if (c1 == '1') {
      colors1[a] = c1;
    } else {
      colors1[a] = c0;
    }
  }
}
void draw() {
  s = Integer.toString(n1, base);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
      //println(s);
      //println(b, d);
    }
    //background(255);
  }
  n0 = max(offset, frameCount + offset - (height/cellHeight) * (width/distance/cellWidth));
  int l = min(s.length(), maxNumber, distance);
  for (int x = 0; x < l; x++) {
    char c1 = s.charAt(s.length() - x - 1);
    //println(c1);
    if (48 <= int(c1) && int(c1) <= 57) {
      c = colors1[int(c1) - 48];
    } else {
      if (97 <= int(c1) && int(c1) <= 122) {
        c = colors1[int(c1) - 87];
      }
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_互补_大小%dx%d_格子尺寸%dx%d_%d进制_数值对应的颜色%s_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, color1, n0, frameCount + offset - 1, c0, c1, backgroundColor);
  //println(b, d);
  if (b == (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(frameCount + offset - 1, s, d, n0, n1);
    println(frameName);
    saveFrame(frameName);
  }
  d++;
  n1++;
}
void mousePressed() {
  if (mouseButton == LEFT) {
    if (r) {
      r = false;
      noLoop();
    } else {
      r = true;
      loop();
    }
  } else {
    if (mouseButton == RIGHT) {
      println(frameCount + offset - 2, s, d, n0, n1 - 1);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
void reverse_color1() {
  char[] c = new char[base];
  for (int x = 0; x < base; x++) {
    if (color1.charAt(x) == '0') {
      c[x] = '1';
    } else {
      c[x] = '0';
    }
  }
  color1 = new String(c);
  for (int a = 0; a < base; a++) {
    char c2 = color1.charAt(base - a - 1);
    if (c2 == '1') {
      colors1[a] = c1;
    } else {
      colors1[a] = c0;
    }
  }
  println("按位取反之后:", color1);
}
void reverse_c0_c1() {
  if (c0 == 255) {
    c0 = 0;
    c1 = 255;
  } else {
    c0 = 255;
    c1 = 0;
  }
  for (int a = 0; a < base; a++) {
    char c2 = color1.charAt(base - a - 1);
    if (c2 == '1') {
      colors1[a] = c1;
    } else {
      colors1[a] = c0;
    }
  }
  println("1对应", c1, " 0对应", c0);
}
void keyPressed() {
  switch (key) {
    case '1':
      reverse_color1();
      break;
    case '2':
      reverse_c0_c1();
      break;
  }
}
