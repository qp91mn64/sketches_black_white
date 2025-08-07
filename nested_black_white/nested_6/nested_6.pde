/**
 2025/8/3 - 2025/8/7
 黑和白的舞蹈
 
 嵌套
 周期
 
 对指定数字不断转换
 查看每次转换的结果以及周期
 
 不少数字最后全0或全1
 也有部分最后0和1都会出现
 周期上似乎各种周期都有
 部分周期可能难找
 至于位数貌似最后要么不再变化
 要么两种不同位数交替出现
 */
int cellWidth = 10;  // 格子宽度
int cellHeight = 10;  // 格子高度
int d = 0;
int b = 0;
int distance = 10;  // 相邻两列之间距离
int nth = 1; // 查看特定数位用。画出第nth位到第nth + distance - 1位。1指最低位。不足的不画。
int n = int(random(100000));  // 转换用的数值，随机取值或指定数值
int count = 0;  // 累计转换次数
String conversionString1 = "10";  // 初始转换字符串，最左边对应最大的数码，最右边对应0
String numberString;  // 数值对应的字符串
String frameName;  // 保存的图片名称
String[] numberStringArray;
boolean r = true;
boolean p = false;
int c = 0;
color color_0 = 255;
color color_1 = 0;
color backgroundColor = 204;  // 背景颜色
void setup() {
  smooth();
  noStroke();
  size(300, 250);
  background(backgroundColor);
  frameRate(10);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  numberString = conversionString1;
  println(n);
}
void draw() {
  numberString = conversion(n, numberString);
  count++;
  println(count, Integer.toString(n,9),numberString);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  
  for (int x = 0; x < distance; x++) {
    try {
      char char1 = numberString.charAt(numberString.length() - x - nth);
      if (char1 == '1') {
        c = color_1;
      } else {
        c = color_0;
      }
    }
    catch (StringIndexOutOfBoundsException e) {
      c = backgroundColor;
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_嵌套_周期_%dx%d格_格子尺寸%dx%d_数字%d_初始转换字符串%s_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, n, conversionString1, color_0, color_1, backgroundColor);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(numberString);
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
      println(numberString);
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
