/**
 2025/7/7 - 2025/7/8
 黑和白的舞蹈
 n ^ p
 
 最后取二进制
 offset的作用是可以直接看很后面的
 
 p = 1即常规黑和白的舞蹈图形
 p = 2即n * n，quadratic_1.pde画出的图形
 p >= 3画出的图形更加复杂
 p太大会画不下
 
 初步观察，似乎p一定时画出的图形可以按照二项式定理分成各个部分
 每个部分，从右往左，分别对应常数项，一次项，二次项，三次项，...，再分别乘以相应系数？
 p较大时各个部分相互重叠与产生的进位混在一起不易观察
 把offset设置为2的较大的幂，或者稍小一点，可以在一定程度上分离不同部分便于观察
 而且最左边的最高次幂在没有与其他部分重合，没有进位的情况下，与offset = 0的情况相同？
 调用java.math.BigInteger计算更大的整数以免溢出
 */
import java.math.BigInteger;

int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int maxNumber = 800;  // 最大数位数
int distance = 800;  // 相邻两列之间距离
int d = 0;
int b = 0;
int p = 15;  // 幂
String s;  //把十进制数值转换成二进制字符串
String frameName;  // 保存的图片名称
boolean r = true;
color backgroundColor = 255;
BigInteger offset = new BigInteger("1111111111111111111111111111111111111111111110000000", 2);  // 初始值
BigInteger n0 = offset;  // 当前图上n最小值
BigInteger n1 = offset.subtract(new BigInteger("1"));  // 当前图上n最大值
void setup() {
  smooth();
  noStroke();
  size(800, 400);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
}
void draw() {
  n1 = n1.add(new BigInteger("1"));
  BigInteger n2 = n1.pow(p);
  s = n2.toString(2);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  //println(n1, n2, s);  // 结合大格子和慢更新查看对应的二进制数
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
  frameName = String.format("黑和白的舞蹈_n^%d_画布大小%dx%d_格子尺寸%dx%d_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", p, width, height, cellWidth, cellHeight, n0, n1, backgroundColor);
  //println(b, d);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(s, n0, n1, n0.pow(p), n1.pow(p));
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
      println(s, n0, n1, n0.pow(p), n1.pow(p));
      println(frameName);
      saveFrame(frameName);
    }
  }
}
