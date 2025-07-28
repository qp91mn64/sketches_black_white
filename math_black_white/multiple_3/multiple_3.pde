/**
 2025/7/24 - 2025/7/25
 黑和白的舞蹈
 p * n + a0
 第三进制
 
 先取p倍，加上a0，再取指定进制
 
 可以随机或指定p和a0的值，调整colorString
 base默认取colorString的位数
 
 offset的作用是方便看很后面的值
 
 只需考虑p不是base的整数倍
 a0小于p的情形
 
 multiple_1.pde对应a0 = 0, colorString = "10"的特例
 multiple_2.pde对应colorString = "10"的特例
 a0 = 0时
 与multiple_1.pde类似
 高位部分像第三进制图形
 低位部分因p取值而异
 有可能画出类似多重第三进制图形
 有可能画出隐藏图形
 可以用Integer.valueOf()帮助寻找特定图形
 其中进制取colorString的位数
 一串0似乎对应分开的多重图形
 全取最大数码似乎低位有colorString反序画出的图形
 全取一个不是最大的数码似乎低位有隐藏图形
 */
int cellWidth = 1;
int cellHeight = 1;
int p = int(random(1000));  // 一次项系数
int offset = 0;  // 初始值，可以看后面的值
int maxNumber = 12;  // 最大数位数
int distance = 12;  // 相邻两列之间距离
int a0 = int(random(p));  // 常数项
int base;
int d = 0;
int b = 0;
int n0 = offset;  // 当前图上n最小值
int n1 = offset - 1;  // 当前图上n最大值
int c = 0;
int[] colorArray;  // 对应颜色数组
String colorString = "100";  // 颜色字符串
String s;  // 数值对应的字符串
String frameName;  // 保存的图片名称
boolean r = true;
color color_0 = 255;  // 0对应白色
color color_1 = 0;  // 1对应黑色
color backgroundColor = 255;
void setup() {
  smooth();
  noStroke();
  size(400, 400);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  base = colorString.length();
  colorArray = new int[base];
  for (int a = 0; a < base; a++) {
    char char1 = colorString.charAt(base - a - 1);
    if (char1 == '1') {
      colorArray[a] = color_1;
    } else {
      colorArray[a] = color_0;
    }
  }
  println(p, Integer.toString(p, base), a0);
}
void draw() {
  n1++;
  s = Integer.toString(n1 * p + a0, base);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  //println(s);
  n0 = max(offset, n1 - (height / cellHeight) * max(1, width / cellWidth / distance) + 1);
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
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_%dn+%d_第三进制_%dx%d格_格子尺寸%dx%d_%d进制_数值对应的颜色%s_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", p, a0, width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, colorString, n0, n1, backgroundColor);
  //println(b, d);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(s, n0, n1, n0 * p + a0, n1 * p + a0);
    println(frameName);
    saveFrame(frameName);
  }
  d++;
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
      println(s, n0, n1, n0 * p + a0, n1 * p + a0);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
