/**
  2025/7/1 - 2025/7/2
  黑和白的舞蹈
  p * n + a0
  
  先取p倍，加上a0，再取二进制

  offset的作用是方便看很后面的值
  
  如果a0大于等于p
  不妨设a0 = n1 * p + n2，其中n1 >= 1，0 <= n2 < p，
  则p * n + a0 = p * n + n1 * p + n2 = p * (n + n1) + n2
  相当于n加了一个值
  故只需考虑a0小于p的情形
  */
int cellWidth = 1;
int cellHeight = 1;
int p = int(random(2000));  // 一次项系数
int offset = 0;  // 初始值
int maxNumber = 24;  // 最大数位数
int distance = 24;  // 相邻两列之间距离
int a0 = int(random(p));  // 常数项
int d = 0;
int b = 0;
int n0 = offset;  // 当前图上n最小值
int n1 = offset - 1;  // 当前图上n最大值
String s;  //把十进制数值转换成二进制字符串
String frameName;  // 保存的图片名称
boolean r = true;
color backgroundColor = 255;
void setup() {
  smooth();
  noStroke();
  size(400, 800);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  println(p, Integer.toBinaryString(p), a0);
}
void draw() {
  n1++;
  s = Integer.toBinaryString(n1*p+a0);
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
    int c;
    if (s.charAt(s.length() - x - 1) == '1') {
      c = 0;
    } else {
      c = 255;
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_%dn+%d_画布大小%dx%d_格子尺寸%dx%d_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", p, a0, width, height, cellWidth, cellHeight, n0, n1, backgroundColor);
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
