/**
 2025/7/17 - 2025/7/21
 黑和白的舞蹈
 
 嵌套
 
 颜色字符串是递增的二进制数
 嵌套意味着
 先转成二进制
 然后按位数和每一位的数值再转换进制画图
 最后的进制是固定的不会随着数值变化
 这样就便于观察不同进制的特点
 而且可以从0开始画
 
 这里可调参数比较多
 调整不同的格子尺寸，最大数位数，相邻两列距离，画布尺寸，画哪几个数位，以及数字进制可查看不同图形
 
 可能使用方式
 
 可以使用大格子或1x1的小格子
 大格子也可以加上边框数格子
 可以单独画每一位数字
 也可以结合nth挑连续几位数字或者画出所有数位
  
 点击鼠标左键暂停再点击继续
 点击鼠标右键保存图形
 画满自动保存图形
 
 offset可以看后面的
 
 部分可能图形
 
 只画一位数字
 似乎画到n取几千，进制较大之后，出现了错开的图形
 只画最低位
 一列格子数等于进制的整数倍时有可能出现一片区域是类似黑和白的舞蹈转置图形
 只画倒数第二位
 网格线条交错
 有些情况下可能十分整齐，纵横交错，纵向交错的局部像黑和白的舞蹈转置的局部周期图形，横向交错的间隔宽度也按一定规律排列
 此时一列格子数是进制二次方的整数倍，猜测最好中间相差的倍数也是2的幂
 如果少几个格子就会从左上往右下错开，多几个格子就从左下往右上错开，错开程度与相差的格子数量有关
 有些进制，可能会在某些行出现平行四边形，另一些行的竖线稍有错开而总体上仍然满足类似规律，也有些进制出现的是矩形
 只画倒数第三位
 可能出现类似常规黑和白的舞蹈的图形或者错开之后有一点像其他进制画出的图形
 只画倒数第四位
 有宽窄不等的横竖斜线或大小不等的平行四边形矩形块，相对单一
 画几位数字
 小格子，则相应位的数字对应图形隐藏于更复杂的整个图形之中
 大格子，则规律不是很明显，有点整齐
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int d = 0;
int b = 0;
int maxDigits = 10;  // 最大数位数
int distance = 10;  // 相邻两列之间距离
int base = 2;  // 进制
int nth = 1;  // 查看特定数位用。画出第nth位到第nth + min(maxDigits, distance) - 1位。1指最低位。不足的不画。
int offset = 0;  // 数值从这里开始一帧加1。不小于2以免画不出预期图形。可以看后面的。
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset - 1;  // 当前图上对应数值最大值
int[] colorArray;  // 对应颜色数组
String colorString;  // 颜色对应的字符串，这里最左边是最大的数字对应的颜色，最右边是0对应的颜色
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
  colorArray = new int[base];
  printArray(colorArray);
}
void draw() {
  n1++;
  colorString = Integer.toString(n1, 2);
  if (colorString.length() > base) {
    colorString = colorString.substring(colorString.length() - base);
  } else {
    while (colorString.length() < base) {
      colorString = "0" + colorString;
    }
  }
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
  }
  numberString = Integer.toString(n1, base);
  println(n1, colorString, base, numberString);  // 查看画到多少，进制，颜色字符串等信息
  for (int a = 0; a < base; a++) {
    char char1;
    try {
      char1 = colorString.charAt(colorString.length() - a - 1);
      if (char1 == '1') {
        colorArray[a] = color_1;
      } else {
        colorArray[a] = color_0;
      }
    } catch (StringIndexOutOfBoundsException e) {
      colorArray[a] = backgroundColor;
    }
  }
  n0 = max(offset, frameCount + offset - (height/cellHeight) * max(1, width/distance/cellWidth));
  int l = min(numberString.length(), maxDigits, distance);
  for (int x = 0; x < l; x++) {
    try {
      char c1 = numberString.charAt(numberString.length() - x - nth);
      if (48 <= int(c1) && int(c1) <= 57) {
        c = colorArray[int(c1) - 48];
      } else {
        if (97 <= int(c1) && int(c1) <= 122) {
          c = colorArray[int(c1) - 87];
        }
      }
    }
    catch (StringIndexOutOfBoundsException e) {
      c = backgroundColor;
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_嵌套_%dx%d格_格子尺寸%dx%d_数字进制%d_数位范围%d到%d_数字范围%d到%d_0的颜色%d_1的颜色%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, nth, nth + min(maxDigits, distance) - 1, n0, frameCount + offset - 1, color_0, color_1, backgroundColor);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
    println(n0, n1, colorString, numberString);
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
      println(n0, n1, colorString, numberString);
      println(frameName);
      saveFrame(frameName);
    }
  }
}
