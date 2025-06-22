/**
 黑和白的舞蹈
 
 静态图形
 
 之前的代码都是一行一行（一列一列）地动态刷新
 现在不动态刷新，直接画满整个画布再显示
 点击鼠标左键更新画布
 点击鼠标右键保存图形
 能得到原来画满再保存得到的图形
 不能得到画到一半的效果
 但是画的更快
 
 互补
 
 键盘控制：
 按下数字1键按位取反
 按下数字2键交换0、1颜色
 查看控制台的信息和视觉效果的变化
 比较两种不同方式是否有差异
 */
int cellWidth = 2;
int cellHeight = 1;
int maxNumber = 10;  // 最大数位数
int distance = maxNumber;  // 相邻两列之间距离
int base = 19;  // 进制，似乎最多只能支持36进制，基数更大会按照十进制处理
int offset = 110000000;  // 数值从这里开始一帧加1
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset;  // 除了初始值以外，n1-1才是当前图上对应数值最大值
int[] colors1 = new int[base];  // 对应颜色数组
String s;  //把十进制数值转换成指定进制字符串
String imageName;  // 保存的图片名称
String color1 = "0000000001010000100";  // 颜色对应的字符串，这里最左边是最大的数字对应的颜色，最右边是0对应的颜色
int c = 0;
color c0 = 255;  // 0对应白色
color c1 = 0;  // 1对应黑色
color backgroundColor = 255;
void setup() {
  smooth();
  noStroke();
  size(800, 800);
  background(backgroundColor);
  noLoop();
  for (int a = 0; a < base; a++) {
    char c2 = color1.charAt(base - a - 1);
    if (c2 == '1') {
      colors1[a] = c1;
    } else {
      colors1[a] = c0;
    }
  }
}
void draw() {
  n0 = n1;
  for (int b = 0; b <= width / cellWidth - distance; b += distance) {
    for (int d = 0; d < height/cellHeight; d++) {
      s = Integer.toString(n1, base);
      //println(s);
      //println(b, d);
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
      n1++;
    }
  }
  imageName = String.format("黑和白的舞蹈_静态图形_大小%dx%d_格子尺寸%dx%d_%d进制_数值对应的颜色%s_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, color1, n0, n1 - 1, c0, c1, backgroundColor);
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
    n1 = n0;
    redraw();
    break;
  case '2':
    reverse_c0_c1();
    n1 = n0;
    redraw();
    break;
  }
}
