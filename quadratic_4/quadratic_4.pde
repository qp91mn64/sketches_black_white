/**
 2025/7/6
 黑和白的舞蹈
 a2 * (n + n0) ^ 2 + a0
 
 最后取二进制
 
 调整n0可以直接看很后面的
 
 只用考虑a2和a0中有奇数的情形
 
 使用方式
 设置a2，n0, a0的值，观察图形
 默认随机取值，可以调整随机取值范围
 也可以固定一些参数的值调整其余参数的值观察图形的变化
 与quadratic_3.pde比较不同公式形式带来的差异
 quadratic_3.pde有些参数取值对应到quadratic_4.pde可能需要负数系数加上忽略开头只有一种颜色的部分
 不确定系数取负值是否能画出预期图形
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
BigInteger a2 = BigInteger.valueOf(int(random(10)) + 1);  // 二次项系数
BigInteger n0 = BigInteger.valueOf(int(random(100000)));  // 实数范围内的极值点
BigInteger a0 = BigInteger.valueOf(int(random(100)));  // 实数范围内的相应极值
BigInteger offset = new BigInteger("0");  // 当前图上n最小值
BigInteger nMin = offset;  // 当前图上n最小值
BigInteger n = offset.subtract(new BigInteger("1"));  // n当前值也是图上的最大值
void setup() {
  smooth();
  noStroke();
  size(400, 800);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  println("a2:", a2, a2.toString(2));
  println("n0:", n0, n0.toString(2));
  println("a0:", a0, a0.toString(2));
}
void draw() {
  n = n.add(new BigInteger("1"));
  BigInteger n2 = (a2.multiply(n.add(n0)).multiply(n.add(n0))).add(a0);
  s = n2.toString(2);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  //println(nMin, n2, s);  // 观察n2的二进制数值，结合较大的格子和较小的更新速度
  nMin = offset.max(n.subtract(BigInteger.valueOf((height / cellHeight) * max(1, width / cellWidth / distance) - 1)));
  int l = min(s.length(), maxNumber, distance);
  for (int x = 0; x < distance; x++) {
    int c;
    if (x >= l) {
      c = backgroundColor;
    }  else {
      if (s.charAt(s.length() - x - 1) == '1') {
        c = 0;
      } else {
        c = 255;
      }
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_%d(n+%d)^2+%d_画布大小%dx%d_格子尺寸%dx%d_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", a2, n0, a0, width, height, cellWidth, cellHeight, nMin, n, backgroundColor);
  //println(b, d);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(s, nMin, n, (a2.multiply(nMin.add(n0)).multiply(nMin.add(n0))).add(a0), (a2.multiply(n.add(n0)).multiply(n.add(n0))).add(a0));
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
      println(s, nMin, n, (a2.multiply(nMin.add(n0)).multiply(nMin.add(n0))).add(a0), (a2.multiply(n.add(n0)).multiply(n.add(n0))).add(a0));
      println(frameName);
      saveFrame(frameName);
    }
  }
}
