/**
黑和白的舞蹈

从左往右，从上往下，每一行都是一个一次加1的二进制数的最后若干位
1对应黑色，0对应白色
  也可以设置不同颜色
画满一列之后就隔一定间隔另起一列继续画
画满屏幕之后从左上角接着画
这里不清零，后面画的图形会覆盖已有的图形
其余没有绘制的部分保持背景颜色，不足位数不用0填充
这里不把得到的二进制数无论多少位都画满
也不一定非要从0开始
  如果想从一个正数开始
  只要设置offset大于0
可以保存画出的图形

得到的结果像不像黑和白的舞蹈？
  每一列最左边都是复杂精致有规律的细节
  从左往右每一位的周期加倍
    使得在重复中又总是有所不同
    直到较长周期之后才会重复之前图案
  右侧形成了大大小小像三角形的区域
    三角形的边像两侧伸展弯曲逐渐变得竖直
  每个三角形上半部分黑下半部分白
    而右侧又是那么整齐
  若图案行数合适
    水平方向就像三角形的整齐排列
    各列成了相同数量一块一块区域
    每一块区域大小高度相同
    整齐排列
    大三角形沿斜线排列
  黑色部分就像竖直的毛发
    嵌入图案
  每一条连续的竖直黑线
    左侧直到最小的细节
    都是上下黑白对称的
    0对应1
    1对应0
    增加对应减少
    而这一条竖直黑线
    也对应于更大周期的白线
  图案更新时
    左侧部分被轻轻跳过
    跳过宽度由图案行数决定
    右侧部分被刷新，黑白交错出现
  而不同大小的三角形只是换了个地方出现
  快到画出的最高位进位时
    黑色线条更多
    黑色更密
    直到最后一行
    填满整个间隙
  进位之后
    则是白色填满整行
    白色更多
    然后再逐渐加灰加黑
  较高进位黑白类似变化
    先是黑色更多
    直至局部填满
    然后白色取代黑色填满的区域
    黑色则再次逐渐增加
    只是变化程度稍小
  黑白错落有致
    恰似黑和白的舞蹈

改变背景颜色可以实现不同视觉效果
  直到填满为止
尽管画满之后在更新的过程中多出的位数会带来不同的视觉效果
其实设置不同宽度高度可以实现不尽相同的效果
*/
int cellWidth = 1;
int cellHeight = 1;
int d = 0;
int b = 0;
int maxNumber = 16;  // 最大数位数
int distance = 16;  // 相邻两列之间距离
int offset = 0;  // 二进制数的值从这里开始一帧加1
int n0 = offset;  // 当前图上对应二进制数最小值，不可能小于offset
int n1 = offset;  // 当前图上对应二进制数最大值
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
}
void draw() {
  s = Integer.toBinaryString(n1);
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
    int c;
    if (s.charAt(s.length() - x - 1) == '1') {
      c = 0;
    } else {
      c = 255;
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_大小%dx%d_格子尺寸%dx%d_二进制数范围%d到%d_0的颜色255_1的颜色0_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, n0, frameCount + offset - 1, backgroundColor);
  //println(b, d);
  if (b == (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(frameCount + offset - 1, s, d, n0, n1);
    println(frameName);
    saveFrame(frameName);
  }
  d++;
  n1++;
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
      println(frameCount + offset - 2, s, d, n0, n1 - 1);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
