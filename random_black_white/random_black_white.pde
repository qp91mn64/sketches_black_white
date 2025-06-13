/**
 黑和白的舞蹈
 
 随机
 
 数制基数
 每个数值对应黑色还是白色
 格子尺寸
 最大数位长度和间距
 都是随机的
 得到的视觉效果也是随机的
 
 从左往右，从上往下，每一行都是一数字最后若干位
 每行比上一行恰好多出1
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
 有几进制对应颜色方案就有2的几次方种
 从全0到全1
 分别对应一个二进制数
 依次画出又是黑和白的舞蹈
 只要每一位都能表现出来
 全0都是白色全1都是黑色
 01都有则开始出现复杂细节
 0越多颜色越白越浅
 1越多颜色越黑越深
 黑白错落有致
 恰似黑和白的舞蹈
 
 改变背景颜色可以实现不同视觉效果
 直到填满为止
 改变随机取值范围
 会使得到不同视觉效果概率变化
 要得到某一类特定视觉效果
 可以减小部分参数随机范围或者取固定值
 */
int cellWidth = int(random(1, 10));
int cellHeight = int(random(1, 5));
int d = 0;
int b = 0;
int maxNumber = int(random(5, 33));  // 最大数位数
int distance = maxNumber;  // 相邻两列之间距离
int base = int(random(2, 37));  // 进制，似乎最多只能支持36进制，基数更大会按照十进制处理
int offset;  // 数值从这里开始一帧加1
int n0;  // 当前图上对应数值最小值，不可能小于offset
int n1;  // 当前图上对应数值最大值
int[] colors1 = new int[base];  // 对应颜色数组
String s;  //把十进制数值转换成指定进制字符串
String frameName;  // 保存的图片名称
String color1= "";  // 颜色对应的字符串，这里最左边是最大的数字对应的颜色，最右边是0对应的颜色
boolean r = true;
int c = 0;
color c0 = 255;  // 0对应白色
color c1 = 0;  // 1对应黑色
color backgroundColor = 255;
void setup() {
  char[] colors = new char[base];
  smooth();
  noStroke();
  size(400, 800);
  background(backgroundColor);
  frameRate(500 / cellHeight);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  for (int a = 0; a < base; a++) {
    float f = random(1);
    if (f < 0.5) {
      colors[base-1-a] = '1';
      colors1[a] = c1;
    } else {
      colors[base-1-a] = '0';
      colors1[a] = c0;
    }
  }
  int a = int(random(0, 100)) + 1;
  offset = (a-1) - (a-1)*(a-1)/2 + (a-1)*(a-1)*(a-1)/3 - (a-1)*(a-1)*(a-1)*(a-1)/4 + (a-1)*(a-1)*(a-1)*(a-1)/5*(a-1) - 1 ;
  n0 = offset;
  n1 = offset;
  color1 = new String(colors);
  println(color1);
  println(base, maxNumber, offset, cellWidth, cellHeight);
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
    char c2 = s.charAt(s.length() - x - 1);
    //println(c2);
    if (48 <= int(c2) && int(c2) <= 57) {
      c = colors1[int(c2) - 48];}
    else {
      if (97 <= int(c2) && int(c2) <= 122) {
        c = colors1[int(c2) - 87];
      }
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_大小%dx%d_格子尺寸%dx%d_%d进制_数值对应的颜色%s_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, color1, n0, frameCount + offset - 1, c0, c1, backgroundColor);
  //println(b, d);
  if (b == (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(frameCount + offset - 1, s, d, n0, n1);
    println(frameName);
    saveFrame(frameName);
  }
  d ++;
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
      println(frameCount + offset, s, d, n0, n1);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
