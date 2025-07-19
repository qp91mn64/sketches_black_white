/**
 2025/7/4
 黑和白的舞蹈
 a2 * n * n + a1 * n + a0
 
 最后取二进制
 
 offset的作用是可以直接看很后面的
 
 只用考虑a2，a1，a0中有奇数的情形
 
 使用方式
 设置a2，a1，a0，offset的值，观察图形
 默认随机取值，可以调整随机取值范围
 也可以固定一些参数的值调整其余参数的值观察图形的变化
 设置合适的格子尺寸和更新速度
 窄长格子能观察一些隐藏图形
 点击鼠标左键暂停再点击继续画
 点击鼠标右键保存图形
 控制台查看有关信息
 
 调用java.math.BigInteger计算更大的整数以免溢出
 */
import java.math.BigInteger;

int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int maxNumber = 32;  // 最大数位数
int distance = 32;  // 相邻两列之间距离
int d = 0;
int b = 0;
String s;  //把十进制数值转换成二进制字符串
String frameName;  // 保存的图片名称
boolean r = true;
color backgroundColor = 255;
BigInteger offset = new BigInteger("10000000");  // 初始值
BigInteger n0 = offset;  // 当前图上n最小值
BigInteger n1 = offset.subtract(new BigInteger("1"));  // 当前图上n最大值
BigInteger a2 = BigInteger.valueOf(int(random(100)) + 1);  // 二次项系数
BigInteger a1 = BigInteger.valueOf(int(random(100)));  // 一次项系数
BigInteger a0 = BigInteger.valueOf(int(random(100)));  // 常数项
void setup() {
  smooth();
  noStroke();
  size(400, 800);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  println("a2:", a2, a2.toString(2));
  println("a1:", a1, a1.toString(2));
  println("a0:", a0, a0.toString(2));
}
void draw() {
  n1 = n1.add(new BigInteger("1"));
  BigInteger n2 = (a2.multiply(n1).multiply(n1)).add(a1.multiply(n1)).add(a0);
  s = n2.toString(2);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  //println(n1, n2, s);  // 观察n2的二进制数值，结合较大的格子和较小的更新速度
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
  frameName = String.format("黑和白的舞蹈_%dn2+%dn+%d_画布大小%dx%d_格子尺寸%dx%d_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", a2, a1, a0, width, height, cellWidth, cellHeight, n0, n1, backgroundColor);
  //println(b, d);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(s, n0, n1, (a2.multiply(n0).multiply(n0)).add(a1.multiply(n0)).add(a0), (a2.multiply(n1).multiply(n1)).add(a1.multiply(n1)).add(a0));
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
      println(s, n0, n1, (a2.multiply(n0).multiply(n0)).add(a1.multiply(n0)).add(a0), (a2.multiply(n1).multiply(n1)).add(a1.multiply(n1)).add(a0));
      println(frameName);
      saveFrame(frameName);
    }
  }
}
