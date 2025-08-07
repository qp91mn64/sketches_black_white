/**
 2025/8/3 - 2025/8/7
 黑和白的舞蹈
 
 嵌套
 周期
 
 不断转换看周期
 查看从offset开始各数字在指定初始转换字符串时对应周期
 周期值转二进制画出
 与其余已有代码一样
 最低位画在最左边
 
 似乎不同周期对应最小数字不随周期递增
 有些周期更难找
 初始转换字符串10的情况下
 最小3337有周期8
 16222有周期10
 16193有周期12
 到了124095才有7周期的
 后面还有周期14，20，24等的
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int d = 0;
int b = 0;
int maxDigits = 5;  // 最大数位数
int distance = 5;  // 相邻两列之间距离
int nth = 1; // 查看特定数位用。画出第nth位到第nth + min(maxDigits, distance) - 1位。1指最低位。不足的不画。
int offset = 2;  // 数值从这里开始一帧加1。不小于conversionString1位数以免画不出预期图形。可以看后面的。随机或指定值。
int maxCount = 40;  // 转换的最大次数。防止万一计算次数太多导致太慢。
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset - 1;  // 当前图上对应数值最大值
int period;  // 转换周期大小
String conversionString1 = "10";  // 初始转换字符串，最左边对应最大的数码，最右边对应0
String numberString;  // 数值对应的字符串
String frameName;  // 保存的图片名称
String[] numberStringArray;
boolean r = true;
int c = 0;
color color_0_periodic = 255;  // 发现周期，0对应的颜色
color color_1_periodic = 0;  // 发现周期，1对应的颜色
color color_0_not_periodic = 170;  // 未发现周期，0对应的颜色
color color_1_not_periodic = 85;  // 未发现周期，1对应的颜色
color backgroundColor = 204;  // 背景颜色
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
  period = 0;  // 没找到周期用0表示
  for (int a = 0; a < maxCount; a++) {
    int base = conversionString.length();
    numberString = conversion(n1, conversionString);
    //println("n1:", n1, "a:", a, "conversionBase:", base, "conversionString:", conversionString, "numberString:", numberString);  // 观察每次转换的有关信息，就是会拖慢画图速度，count较大就会很慢
    conversionString = numberString;
    numberStringArray[a] = numberString;
    for (int a1 = 0; a1 < a; a1++) {
      if (numberStringArray[a1].equals(numberStringArray[a])) {  // 问了AI（DeepSeek的深度思考（R1）），要使用equals()。根据AI回答，直接用"=="比较的是内存地址，而自行写的conversion()函数返回的总是新字符串内存地址不同所以总是不等。如果使用常量字符串例如"111"调试，哪怕拆成运算式子例如""+"1"+"11"，Java字符串常量池机制会使得赋值时相同值的常量字符串（字面量/编译时常量）会指向同一对象，"=="比较又返回true找不到bug。
        period = a - a1;
        if (period >= 12) {
          println(String.format("初始转换字符串%s的条件下，%d的周期是%d", conversionString1, n1, period));  // 查看每个数字在特定初始转换字符串下的周期。可以用if语句来筛选特定转换周期的数字以辅助寻找7等相对少见的周期
        }
        break;
      }
    }
    if (period > 0) {
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
  numberString = Integer.toString(period, 2);  // 画周期值
  n0 = max(offset, frameCount + offset - (height/cellHeight) * max(1, width/distance/cellWidth));
  int l = min(numberString.length(), maxDigits, distance);
  for (int x = 0; x < distance; x++) {
    if (x < l) {
      try {
        char char1 = numberString.charAt(numberString.length() - x - nth);
        if (char1 == '1') {
          if (period > 0) {
            c = color_1_periodic;
          } else {
            c = color_1_not_periodic;
          }
        } else {
          if (period > 0) {
            c = color_0_periodic;
          } else {
            c = color_0_not_periodic;
          }
        }
      }
      catch (StringIndexOutOfBoundsException e) {
        c = backgroundColor;
      }
    } else {
      c = backgroundColor;
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_嵌套_周期_%dx%d格_格子尺寸%dx%d_最大转换次数%d_初始转换字符串%s_数位范围%d到%d_数字范围%d到%d_发现周期0的颜色%d_1的颜色%d_未发现周期0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, maxCount, conversionString1, nth, nth + min(maxDigits, distance) - 1, n0, frameCount + offset - 1, color_0_periodic, color_1_periodic, color_0_not_periodic, color_1_not_periodic,backgroundColor);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
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
