/**
 2025/7/5
 黑和白的舞蹈
 p ^ n
 
 最后取二进制
 
 指数计算得到数字比较大有可能一列画不下只能画出最后几百位
 为了区分，背景不用白色
 offset的作用是可以直接看很后面的
 
 只用考虑p不是2的幂的情形
 
 使用方式
 设置p的值，观察图形
 默认随机取值，可以调整随机取值范围或设置固定值
 点击鼠标左键暂停再点击继续画
 点击鼠标右键保存图形
 控制台查看有关信息
 
 初步观察的一些猜测：
 当p是2的幂的时候每一行只有一个格子涂黑
 p是偶数但是不是2的幂出现空白部分和看起来很复杂的黑白交错部分
 p是大于1的奇数出现看起来很复杂的黑白交错部分
 p等于3会出现许多黑色的，白色的小三角形区域
 p等于2的幂加1时，会分成不同列，每列从左到右分别对应常数1，一次项，三角形数部分，四面体数部分等，中间是空白，直到两列相遇，分别对应杨辉三角斜线系数
 其中，一次项即常规的黑和白的舞蹈图形，二次项即quadratic_3.pde中a2=a1=1（注意是BigInteger）忽略空白列的图形，其余更高次幂暂时没有画出来
 p等于2的幂减1时也有很多列，但是不是常规图形，中间是横条纹，直到两列相遇，没看出其他的规律
 
 调用java.math.BigInteger计算更大的整数以免溢出
 */
import java.math.BigInteger;

int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int maxNumber = 800;  // 最大数位数
int distance = 800;  // 相邻两列之间距离
int d = 0;
int b = 0;
String s;  //把十进制数值转换成二进制字符串
String frameName;  // 保存的图片名称
boolean r = true;
color backgroundColor = 204;
int offset = 0;  // 初始值
int n0 = offset;  // 当前图上n最小值
int n1 = offset - 1;  // 当前图上n最大值
BigInteger p = BigInteger.valueOf(int(random(100)) + 2);  // 指数
void setup() {
  smooth();
  noStroke();
  size(800, 240);
  background(backgroundColor);
  frameRate(100);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  println("p:", p, p.toString(2));
}
void draw() {
  n1++;
  BigInteger n2 = p.pow(n1);
  s = n2.toString(2);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  //println(n1, n2, s);  // 观察n2的二进制数值，结合较大的格子和较小的更新速度
  n0 = max(offset, n1-((height / cellHeight) * max(1, width / cellWidth / distance) - 1));
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
  frameName = String.format("黑和白的舞蹈_%d^n_画布大小%dx%d_格子尺寸%dx%d_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", p, width, height, cellWidth, cellHeight, n0, n1, backgroundColor);
  //println(b, d);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(s, n0, n1, p.pow(n0), p.pow(n1));
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
      println(s, n0, n1, p.pow(n0), p.pow(n1));
      println(frameName);
      saveFrame(frameName);
    }
  }
}
