/**
 2025/7/20 - 2025/7/24
 黑和白的舞蹈
 
 嵌套
 第三进制
 
 颜色字符串有两个且改名转换字符串
 
 与嵌套相比
 先转指定进制再用第三进制的方式得到转换字符串
 与第三进制相比
 转换字符串也是类似转换的结果
 
 这里可以调整的参数比较多
 调整不同的格子尺寸，最大数位数，相邻两列距离，画布尺寸，conversionString1，画哪几个数位，以及offset可查看不同图形
 
 可能使用方式
 
 可以使用大格子或1x1的小格子
 大格子也可以加上边框数格子
 可以单独画每一位数字
 也可以结合nth挑连续几位数字或者画出所有数位
 conversionString1的内容只有0和1，长度可以从2到36
 conversionString1越长
 第一转换进制越大
 第一转换之后的数字位数越少
 第二转换进制越小
 同一进制对应n的范围越大
 画同样位数对应周期越小
 可以画的位数越多
 
 点击鼠标左键暂停再点击继续
 点击鼠标右键保存图形
 画满自动保存图形
 
 可能的图形
 单纯的嵌套nested_1.pde画出的相对更规整的图形其形状类似常规黑和白的舞蹈，即二进制
 加上第三进制之后类似图形就是第三进制的风格
 可能画出不太规整的图形或许有点像抽象画
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int d = 0;
int b = 0;
int maxDigits = 1;  // 最大数位数
int distance = 1;  // 相邻两列之间距离
int conversionBase1;  // 第一转换进制
int conversionBase2;  // 第二转换进制
int nth = 1;  // 查看特定数位用。画出第nth位到第nth + min(maxDigits, distance) - 1位。1指最低位。不足的不画。
int offset = int(random(3, 10000000));  // 数值从这里开始一帧加1。不小于conversionString1位数以免画不出预期图形。可以看后面的。随机或指定值。
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset - 1;  // 当前图上对应数值最大值
String conversionString1 = "110";  // 第一转换字符串，最左边对应最大的数码，最右边对应0
String conversionString2;  // 第二转换字符串，最左边对应最大的数码，最右边对应0
String numberString;  // 数值对应的字符串
String frameName;  // 保存的图片名称
boolean r = true;
int c = 0;
color color_0 = 255;  // 0对应的颜色
color color_1 = 0;  // 1对应的颜色
color backgroundColor = 255;  // 背景颜色
void setup() {
  smooth();
  noStroke();
  size(300, 250);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  conversionBase1 = conversionString1.length();
}
void draw() {
  n1++;
  String string1 = Integer.toString(n1, conversionBase1);  // 第一次转换进制的中间结果
  conversionString2 = "";
  for (int a = 0; a < string1.length(); a++) {
    int e1 = Integer.valueOf(string1.substring(a, a + 1), 36);  // 每位数码的值
    String c1 = conversionString1.substring(conversionString1.length() - e1 - 1, conversionString1.length() - e1);  // 第一转换的值
    conversionString2 += c1;
  }
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  conversionBase2 = conversionString2.length();
  String string2 = Integer.toString(n1, conversionBase2);  // 第二次转换进制的中间结果
  numberString = "";  // 最终得到的字符串，同时也直接对应相应颜色画图形
  for (int a = 0; a < string2.length(); a++) {
    int e2 = Integer.valueOf(string2.substring(a, a + 1), 36);  // 每位数码的值
    String c2 = conversionString2.substring(conversionString2.length() - e2 - 1, conversionString2.length() - e2);  // 第二转换的值
    numberString += c2;
  }
  println(n1, conversionString2, conversionBase2, string2, numberString);  // 查看画到多少，进制，颜色字符串等信息
  n0 = max(offset, frameCount + offset - (height/cellHeight) * max(1, width/distance/cellWidth));
  int l = min(string2.length(), maxDigits, distance);
  for (int x = 0; x < l; x++) {
    try {
      char char1 = numberString.charAt(numberString.length() - x - nth);
      if (char1 == '1') {
        c = color_1;
      } else {
        c = color_0;
      }
    } catch (StringIndexOutOfBoundsException e) {
      c = backgroundColor;
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_嵌套_第三进制_%dx%d格_格子尺寸%dx%d_第一转换进制%d_第一转换字符串%s_数位范围%d到%d_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, conversionBase1, conversionString1, nth, nth + min(maxDigits, distance) - 1, n0, frameCount + offset - 1, color_0, color_1, backgroundColor);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(n0, n1, conversionString2, numberString);
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
      println(n0, n1, conversionString2, numberString);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
