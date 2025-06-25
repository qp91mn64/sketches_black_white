/**
 2025/6/22 - 2025/6/25
 黑和白的舞蹈
 
 静态图形转置
 
 在静态图形的基础上，把每个格子的行列下标（横纵坐标）互换
 得到静态图形的转置图形
 
 互补
 
 键盘控制：
 按下数字1键按位取反
 按下数字2键交换0、1颜色
 查看控制台的信息和视觉效果的变化
 比较两种不同方式是否有差异
 */
int cellWidth = 1;
int cellHeight = 1;
int maxNumber = 16;  // 最大数位数
int distance = maxNumber;  // 相邻两列之间距离
int base = 31;  // 进制，似乎最多只能支持36进制，基数更大会按照十进制处理
int offset = 100000000;  // 数值从这里开始一帧加1
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset;  // 除了初始值以外，n1-1才是当前图上对应数值最大值
int[] colorArray = new int[base];  // 对应颜色数组
String s;  //把十进制数值转换成指定进制字符串
String imageName;  // 保存的图片名称
String colorString = "1000100001001000001101100001000";  // 颜色对应的字符串，这里最左边是最大的数字对应的颜色，最右边是0对应的颜色
int c = 0;
color color_0 = 255;  // 0对应白色
color color_1 = 0;  // 1对应黑色
color backgroundColor = 255;
void setup() {
  smooth();
  noStroke();
  size(800, 400);
  background(backgroundColor);
  noLoop();
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
  n0 = n1;
  for (int b = 0; b <= height / cellHeight - distance; b += distance) {
    for (int d = 0; d < width / cellWidth; d++) {
      s = Integer.toString(n1, base);
      //println(s);
      //println(b, d);
      int l = min(s.length(), maxNumber, distance);
      for (int x = 0; x < l; x++) {
        char c1 = s.charAt(s.length() - x - 1);
        //println(c1);
        if (48 <= int(c1) && int(c1) <= 57) {
          c = colorArray[int(c1) - 48];
        } else {
          if (97 <= int(c1) && int(c1) <= 122) {
            c = colorArray[int(c1) - 87];
          }
        }
        fill(c);
        rect(d*cellWidth, cellHeight*(x+b), cellWidth, cellHeight);
      }
      n1++;
    }
  }
  imageName = String.format("黑和白的舞蹈_静态图形转置_大小%dx%d_格子尺寸%dx%d_%d进制_数值对应的颜色%s_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, colorString, n0, n1 - 1, color_0, color_1, backgroundColor);
  println(s, n0, n1 - 1);
  println(imageName);
}
void mousePressed() {
  if (mouseButton == LEFT) {
    redraw();
  } else {
    if (mouseButton == RIGHT) {
      println("图片已保存");
      saveFrame(imageName);
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
  if (color_0 == 255) {
    color_0 = 0;
    color_1 = 255;
  } else {
    color_0 = 255;
    color_1 = 0;
  }
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
    n1 = n0;
    redraw();
    break;
  case '2':
    reverse_color_0_color_1();
    n1 = n0;
    redraw();
    break;
  }
}
