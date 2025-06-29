/**
 2025/6/29 
 黑和白的舞蹈
 
 灰色
 转置
 
 背景颜色，0对应的颜色，1对应的颜色是随机的黑白灰
 与grey.pde相比，每个格子的行列下标（横纵坐标）互换得到转置图形
 
 互补
 
 键盘控制：
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
int[] colorArray = new int[base];  // 对应颜色数组
String s;  //把十进制数值转换成指定进制字符串
String frameName;  // 保存的图片名称
String colorString = "10";  // 颜色对应的字符串，这里最左边是最大的数字对应的颜色，最右边是0对应的颜色
boolean r = true;
int c = 0;
color color_0 = int(random(256));  // 0对应白色
color color_1 = int(random(256));  // 1对应黑色
color backgroundColor = int(random(256));
void setup() {
  smooth();
  noStroke();
  size(800, 400);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  for (int a = 0; a < base; a++) {
    char char1 = colorString.charAt(base - a - 1);
    if (char1 == '1') {
      colorArray[a] = color_1;
    } else {
      colorArray[a] = color_0;
    }
  }
}
void draw() {
  s = Integer.toString(n1, base);
  if (cellWidth * (d + 1) > width) {
    d -= width/cellWidth;
    b += distance;
    if (cellHeight * (b + distance) > height) {
      b = 0;
    }
  }
  n0 = max(offset, frameCount + offset - (width/cellWidth) * (height/distance/cellHeight));
  int l = min(s.length(), maxNumber, distance);
  for (int x = 0; x < l; x++) {
    char c1 = s.charAt(s.length() - x - 1);
    if (48 <= int(c1) && int(c1) <= 57) {
      c = colorArray[int(c1) - 48];
    } else {
      if (97 <= int(c1) && int(c1) <= 122) {
        c = colorArray[int(c1) - 87];
      }
    }
    fill(c);
    rect(cellWidth * d, cellHeight * (x + b), cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_灰色_转置_大小%dx%d_格子尺寸%dx%d_%d进制_数值对应的颜色%s_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, colorString, n0, frameCount + offset - 1, color_0, color_1, backgroundColor);
  if (b == (height / cellHeight - (height / cellHeight) % distance) - distance && d == width / cellWidth - 1) {
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
void reverse_colorString() {
  char[] c = new char[base];
  for (int x = 0; x < base; x++) {
    if (colorString.charAt(x) == '0') {
      c[x] = '1';
    } else {
      c[x] = '0';
    }
  }
  colorString = new String(c);
  for (int a = 0; a < base; a++) {
    char c2 = colorString.charAt(base - a - 1);
    if (c2 == '1') {
      colorArray[a] = color_1;
    } else {
      colorArray[a] = color_0;
    }
  }
  println("按位取反之后:", colorString);
}
void reverse_color_0_color_1() {
  color color2 = color_0;
  color_0 = color_1;
  color_1 = color2;
  for (int a = 0; a < base; a++) {
    char c2 = colorString.charAt(base - a - 1);
    if (c2 == '1') {
      colorArray[a] = color_1;
    } else {
      colorArray[a] = color_0;
    }
  }
  println("1对应", color_1, " 0对应", color_0);
}
void keyPressed() {
  switch (key) {
    case '1':
      reverse_colorString();
      break;
    case '2':
      reverse_color_0_color_1();
      break;
  }
}
