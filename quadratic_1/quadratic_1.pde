/**
  2025/6/30 - 2025/7/2
  黑和白的舞蹈
  n * n
  
  先平方再取二进制
  offset的作用是可以直接看很后面的
  
  调用java.math.BigInteger计算更大的整数以免溢出
  */
import java.math.BigInteger;

int cellWidth = 1;
int cellHeight = 1;
int maxNumber = 32;  // 最大数位数
int distance = 32;  // 相邻两列之间距离
int d = 0;
int b = 0;
String s;  //把十进制数值转换成二进制字符串
String frameName;  // 保存的图片名称
boolean r = true;
color backgroundColor = 255;
BigInteger offset = new BigInteger("0");  // 初始值
BigInteger n0 = offset;  // 当前图上n最小值
BigInteger n1 = offset.subtract(new BigInteger("1"));  // 当前图上n最大值
void setup() {
  smooth();
  noStroke();
  size(400, 800);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
}
void draw() {
  n1 = n1.add(new BigInteger("1"));
  BigInteger n2 = n1.multiply(n1);
  s = n2.toString(2);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  //println(n1, n2, s);
  n0 = offset.max(n1.subtract(BigInteger.valueOf((height / cellHeight) * max(1, width / cellWidth / distance) - 1)));
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
  frameName = String.format("黑和白的舞蹈_1n2_画布大小%dx%d_格子尺寸%dx%d_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", width, height, cellWidth, cellHeight, n0, n1, backgroundColor);
  //println(b, d);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(s, n0, n1, n0.multiply(n0), n1.multiply(n1));
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
      println(s, n0, n1, n0.multiply(n0), n1.multiply(n1));
      println(frameName);
      saveFrame(frameName);
    }
  }
}
