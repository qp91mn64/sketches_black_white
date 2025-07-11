/**
 2025/7/8 - 2025/7/11
 黑和白的舞蹈
 (a1 * n + a0) ^ p
 
 最后取二进制
 offset的作用是可以直接看很后面的
 
 p = 1即常规黑和白的舞蹈图形
 p = 2即n * n，quadratic_1.pde画出的图形
 p >= 3画出的图形更加复杂
 p太大会画不下
 
 可能的使用方式
 随便设置a1，a0，p的值看结果
  抽取power_1.pde画出的图形左边的隐藏图形
   a0设定初始值之后不变
   a1从1开始每次翻倍
   不断对上一次画出的图形每两行保留一行
   看最后剩下了什么
   换不同的a0重复上述操作
   最后又剩下了什么
 可以设置a1或a0的值看分离结果
  例如
  二项式分离
   如果把a1设置成2的幂，a0 = 1，指定一个p？
   假设a1用二进制表示，且a1 = 10000000000，a0 = 1，p从1开始增加：
   (10000000000*n + 1)^1 = 10000000000*n + 1
   (10000000000*n + 1)^2 = 100000000000000000000*n^2 + 10*10000000000*n + 1
   (10000000000*n + 1)^3 = 1000000000000000000000000000000*n^3 + 11*100000000000000000000*n^2 + 11*10000000000*n + 1
   (10000000000*n + 1)^4 = 10000000000000000000000000000000000000000*n^4 + 100*1000000000000000000000000000000*n^3 + 110*100000000000000000000*n^2 + 100*10000000000*n + 1
   ......
   于是画出来的图形在一定程度上分成了几个部分
   重叠之前，从左往右依次是常数项、一次项、二次项、三次项、...、最高次项
   而且前面有相应系数
   使用power_2.pde画带系数的幂函数情形
   同时在不同窗口中比较差异
  其余分离方式
   把a1和a0设置成2的几个幂（以及1）的和，再指定一个p
   注意a1和a0都是偶数时，请忽略开头空白部分
 
 调用java.math.BigInteger计算更大的整数以免溢出
 */
import java.math.BigInteger;

int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int maxNumber = 800;  // 最大数位数
int distance = 800;  // 相邻两列之间距离
int d = 0;
int b = 0;
int p = 4;  // 幂
String s;  //把十进制数值转换成二进制字符串
String frameName;  // 保存的图片名称
boolean r = true;
color backgroundColor = 255;
BigInteger offset = new BigInteger("0", 2);  // 初始值
BigInteger a1 = new BigInteger("1000000000000000000000000000", 2);
BigInteger a0 = new BigInteger("1", 2);
BigInteger n0 = offset;  // 当前图上n最小值
BigInteger n1 = offset.subtract(new BigInteger("1"));  // 当前图上n最大值
void setup() {
  smooth();
  noStroke();
  size(240, 400);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
}
void draw() {
  n1 = n1.add(new BigInteger("1"));
  BigInteger n2 = (a1.multiply(n1).add(a0)).pow(p);
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
  frameName = String.format("黑和白的舞蹈_(%dn+%d)^%d_画布大小%dx%d_格子尺寸%dx%d_n的范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", a1, a0, p, width, height, cellWidth, cellHeight, n0, n1, backgroundColor);
  //println(b, d);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(s, n0, n1, (a1.multiply(n0).add(a0)).pow(p), (a1.multiply(n1).add(a0)).pow(p));
    println(frameName);
    //saveFrame(frameName);
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
      println(s, n0, n1, (a1.multiply(n0).add(a0)).pow(p), (a1.multiply(n1).add(a0)).pow(p));
      println(frameName);
      //saveFrame(frameName);
    }
  }
}
