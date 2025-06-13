/**
黑和白的舞蹈

第三进制

base = 4;

改变进制实现不同视觉效果
从左往右，从上往下，每一行都是一数字最后若干位
  这个数字以第三进制表示，每行比上一行恰好多出1
1对应黑色，0对应白色
  也可以设置不同颜色
画满一列之后就隔一定间隔另起一列继续画
画满屏幕之后从左上角接着画
这里不清零，后面画的图形会覆盖已有的图形
其余没有绘制的部分保持背景颜色，不足位数不用0填充
这里不把无论多少位都画满
也不一定非要从0开始
  如果想从一个正数开始
  只要设置offset大于0
可以保存画出的图形

得到的结果像不像黑和白的舞蹈？
  每一列最左边都是复杂精致有规律的细节
  从左往右每一位的周期加倍
    使得在重复中又总是有所不同
    直到较长周期之后才会重复之前图案
  第三进制下
    有几进制对应颜色方案就有2的几次方种
    从全0到全1
    分别对应一个二进制数
    依次画出又是黑和白的舞蹈
    只要每一位都能表现出来
  你可以任选一种方案
    全0都是白色全1都是黑色
    01都有则开始出现复杂细节
    0越多颜色越白越浅
    1越多颜色越黑越深

  黑白错落有致
    恰似黑和白的舞蹈

改变背景颜色可以实现不同视觉效果
  直到填满为止
尽管画满之后在更新的过程中多出的位数会带来不同的视觉效果
其实设置不同宽度高度可以实现不尽相同的效果
*/
int cellWidth = 3;
int cellHeight = 3;
int d = 0;
int b = 0;
int maxNumber = 16;  // 最大数位数
int distance = 10;  // 相邻两列之间距离
int base = 4;  // 进制
int offset = 0;  // 数值从这里开始一帧加1
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset;  // 当前图上对应数值最大值
int[] colors1 = new int[base];  // 对应颜色数组
String s;  //把十进制数值转换成指定进制字符串
String frameName;  // 保存的图片名称
String color1 = "0001";  // 颜色对应的字符串，这里最左边是最大的数字对应的颜色，最右边是0对应的颜色
boolean r = true;
int c = 0;
color c0 = 255;  // 0对应白色
color c1 = 0;  // 1对应黑色
color backgroundColor = 255;
void setup() {
  smooth();
  noStroke();
  size(390,798);
  background(backgroundColor);
  frameRate(100);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  for (int a = 0; a < base; a++) {
    char c1 = color1.charAt(base - a - 1);
    if (c1 == '1') {
      colors1[a] = 0;
    } else {
      colors1[a] = 255;
    }
  }
}
void draw() {
  s = Integer.toString(n1, base);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
      //println(s);
      //println(b, d);
    }
    //background(255);
  }
  n0 = max(offset, frameCount + offset - (height/cellHeight) * (width/distance/cellWidth));
  int l = min(s.length(), maxNumber, distance);
  for (int x = 0; x < l; x++) {
    char c1 = s.charAt(s.length() - x - 1);
    //println(c1);
    if (48 <= int(c1) && int(c1) <= 57) {c = colors1[int(c1) - 48];}
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_大小%dx%d_格子尺寸%dx%d_%d进制_数值对应的颜色%s_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, color1, n0, frameCount + offset - 1, c0, c1, backgroundColor);
  //println(b, d);
  if (b == (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    saveFrame(frameName);
  //println(frameCount + offset - 1, s, d, n0, n1);
  println(frameName);}
  d++;
  n1++;
}
void mousePressed() {
  if (mouseButton == LEFT) {
    if (r) {
      r = false;
      noLoop();
    } else {r = true;
      loop();} 
  } else {
    if (mouseButton == RIGHT) {
      println(frameCount + offset, s, d, n0, n1);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
