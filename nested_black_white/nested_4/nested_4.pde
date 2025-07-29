/**
 2025/7/28 - 2025/7/29
 黑和白的舞蹈
 
 嵌套
 多次转换
 
 每次的结果都作为下一次的转换字符串
 而每次转换用的数值不变
 
 与nested_3.pde相比增加参数count，转换次数
 
 点击鼠标左键暂停再点击继续
 点击鼠标右键保存图形
 画满自动保存图形
 
 可能的图形
 count=1：第三进制图形
 count=2：nested_3.pde图形
  考虑有时出现的更规整的没有错开的图形
  以一列256格子，16进制区域，转换字符串10为例
  nth=1：类似multiple_2.pde转置
  nth=2：nth=1放大版
  nth=3：类似纵向黑和白的舞蹈
  nth=4：nth=3放大版
 count=3：更复杂，nth取合适值画出的图形分成了一块一块的
  此处以第几转换进制区分不同的进制
  以一列256格子，第一转换进制2，第二转换进制16区域，第一转换字符串10，nth=3为例
  此时各转换进制2，16，4
  类似的4大块
  每一大块从上往下4小块
  每一小块似乎分别对应count=2不同nth的图形
  有纵向的横向的宽度依次翻倍黑白条纹的
  到了n1增加到60000多第二转换进制17的区域
  1大块还是分4小块
  其中像count=2，nth=1图形的小块区域内部变成错开图形
  n1增加到80000多
  各转换进制2，17，5时
  大块也错开
  此时如果一列250格
  大块则整齐
  两个大块
  每大块纵向5小块
  每小块横向分成更小的块
 于是count=2，nth=4的对应图形
 看成count=1的图形即常规黑和白的舞蹈图形
 各数位图形依次出现
 
 猜测count取特定值
 每一个nth
 画出的图形
 都是count-1时nth所有可能取值依次出现图形
 且指定的nth越大
 出现的不同区域对应范围越大
 对应范围足够大时
 其中count更小的对应图形或者叫更低层次图形
 也会依次出现
 只要保持count取正数值即可
 只是count较大难以观察出规律
 
 把第三进制图形看作第一转换进制的影响
 继续猜测
 每个转换的进制都会影响最后图形
 从第一转换进制开始
 影响的图形从最细节逐渐到最整体
 某转换进制是几
 对应层次有几个部分
 且n1达到上一转换进制的这一转换进制次幂
 这一转换进制就加1
 相应层次能分出的部分也变化
 
 随着count不断增大
 从打头的数字开始渐渐收敛
 或者进入周期
 由于原数值没变
 猜测每个数字都会进入周期
 而各数位对应的图形
 尽管复杂
 最后也进入周期变化
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int d = 0;
int b = 0;
int maxDigits = 1;  // 最大数位数
int distance = 1;  // 相邻两列之间距离
int nth = 3; // 查看特定数位用。画出第nth位到第nth + min(maxDigits, distance) - 1位。1指最低位。不足的不画。
int offset = 30002;  // 数值从这里开始一帧加1。不小于conversionString1位数以免画不出预期图形。可以看后面的。随机或指定值。
int count = 3;  // 转换的总次数
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset - 1;  // 当前图上对应数值最大值
String conversionString1 = "10";  // 初始转换字符串，最左边对应最大的数码，最右边对应0
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
  size(300, 256);
  background(backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  numberString = conversionString1;
}
void draw() {
  n1+=1;
  String conversionString = conversionString1;
  for (int a = 0; a < count; a++) {
    int base = conversionString.length();
    numberString = conversion(n1, conversionString);
    println("n1:", n1, "a:", a, "conversionBase:", base, "conversionString:", conversionString, "numberString:", numberString);  // 观察有关信息，就是会拖慢画图速度，count较大就会很慢
    conversionString = numberString;
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
  frameName = String.format("黑和白的舞蹈_嵌套_多次转换_%dx%d格_格子尺寸%dx%d_转换次数%d_初始转换字符串%s_数位范围%d到%d_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, count, conversionString1, nth, nth + min(maxDigits, distance) - 1, n0, frameCount + offset - 1, color_0, color_1, backgroundColor);
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
