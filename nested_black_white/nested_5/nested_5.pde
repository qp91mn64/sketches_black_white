/**
 2025/7/30 - 2025/7/31
 黑和白的舞蹈
 
 嵌套
 多次转换
 周期
 
 猜测似乎每个数字都会进入周期
 这里加上判断是否进入周期的部分
 n1确定，转换字符串确定
 则转换的结果也确定
 认为只要相同转换字符串重复出现就已经进入周期
 此时停止转换
 能用颜色区分是否发现周期
 到maxCount已发现周期的部分仍用黑白
 还没发现周期的部分这里默认用灰色画出以作区别
 
 调整maxCount大致查看不同数字发现周期的快慢
 maxCount较大时
 猜测
 设conversionString1有a位
 则a的（a-1）次幂到a的a次幂范围内
 一列格子数取a的合适整数次幂也可以再乘一个整数
 能观察到比较规整又不像有周期的图形
 a的a次幂到（a+1）的a次幂范围内也有不同的图形
 似乎a不小于5效果才明显
 调整nth，maxDigits，distance可以单独画任意一位数字对应的图形
 conversionString1每一位的值则影响具体细节
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int d = 0;
int b = 0;
int maxDigits = 5;  // 最大数位数
int distance = 5;  // 相邻两列之间距离
int nth = 1; // 查看特定数位用。画出第nth位到第nth + min(maxDigits, distance) - 1位。1指最低位。不足的不画。
int offset = 5;  // 数值从这里开始一帧加1。不小于conversionString1位数以免画不出预期图形。可以看后面的。随机或指定值。
int maxCount = 14;  // 转换的最大次数。防止万一计算次数太多导致太慢。
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset - 1;  // 当前图上对应数值最大值
String conversionString1 = "00001";  // 初始转换字符串，最左边对应最大的数码，最右边对应0
String numberString;  // 数值对应的字符串
String frameName;  // 保存的图片名称
String[] numberStringArray;
boolean r = true;
boolean p = false;
int c = 0;
color color_0_periodic = 255;  // 发现周期，0对应的颜色
color color_1_periodic = 0;  // 发现周期，1对应的颜色
color color_0_not_periodic = 170;  // 未发现周期，0对应的颜色
color color_1_not_periodic = 85;  // 未发现周期，1对应的颜色
color backgroundColor = 255;  // 背景颜色
void setup() {
  smooth();
  noStroke();
  size(300, 250);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  numberString = conversionString1;
}
void draw() {
  n1+=1;
  numberStringArray = new String[maxCount];
  String conversionString = conversionString1;
  p = false;
  for (int a = 0; a < maxCount; a++) {
    int base = conversionString.length();
    numberString = conversion(n1, conversionString);
    println("n1:", n1, "a:", a, "conversionBase:", base, "conversionString:", conversionString, "numberString:", numberString);  // 观察每次转换的有关信息，就是会拖慢画图速度，count较大就会很慢
    conversionString = numberString;
    numberStringArray[a] = numberString;
    for (int a1 = 0; a1 < a; a1++) {
      if (numberStringArray[a1].equals(numberStringArray[a])) {  // 问了AI（DeepSeek的深度思考（R1）），要使用equals()。根据AI回答，直接用"=="比较的是内存地址，而自行写的conversion()函数返回的总是新字符串内存地址不同所以总是不等。如果使用常量字符串例如"111"调试，哪怕拆成运算式子例如""+"1"+"11"，Java字符串常量池机制会使得赋值时相同值的常量字符串（字面量/编译时常量）会指向同一对象，"=="比较又返回true找不到bug。
        println(n1);
        p = true;
        break;
      }
    }
    if (p == true) {
      break;
    }
  }
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  n0 = max(offset, frameCount + offset - (height/cellHeight) * max(1, width/distance/cellWidth));
  int l = min(numberString.length(), maxDigits, distance);
  for (int x = 0; x < l; x++) {
    try {
      char char1 = numberString.charAt(numberString.length() - x - nth);
      if (char1 == '1') {
        if (p == true) {
          c = color_1_periodic;
        } else {
          c = color_1_not_periodic;
        }
      } else {
        if (p == true) {
          c = color_0_periodic;
        } else {
          c = color_0_not_periodic;
        }
      }
    }
    catch (StringIndexOutOfBoundsException e) {
      c = backgroundColor;
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_嵌套_多次转换_%dx%d格_格子尺寸%dx%d_最大转换次数%d_初始转换字符串%s_数位范围%d到%d_数字范围%d到%d_发现周期0的颜色%d_1的颜色%d_未发现周期0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, maxCount, conversionString1, nth, nth + min(maxDigits, distance) - 1, n0, frameCount + offset - 1, color_0_periodic, color_1_periodic, color_0_not_periodic, color_1_not_periodic,backgroundColor);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(n0, n1, numberString);
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
      println(n0, n1, numberString);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
String conversion(int number, String conversionString) {
  int conversionBase = conversionString.length();
  String string1 = Integer.toString(number, conversionBase);  // 中间结果
  String conversionString2 = "";
  for (int a = 0; a < string1.length(); a++) {
    int e1 = Integer.valueOf(string1.substring(a, a + 1), 36);  // 每位数码的值
    String c1 = conversionString.substring(conversionString.length() - e1 - 1, conversionString.length() - e1);  // 转换的值
    conversionString2 += c1;
  }
  return conversionString2;
}
