/**
 2025/6/28 - 2025/7/2
 黑和白的舞蹈
 
 随机第三颜色
 
 各数码值分别对应随机灰色
 背景颜色也是随机灰色
 
 点击鼠标左键暂停再点击继续
 按下数字1键更换各数码的值对应的颜色
 */
int cellWidth = 1;
int cellHeight = 1;
int d = 0;
int b = 0;
int maxNumber = 10;  // 最大数位数
int distance = maxNumber;  // 相邻两列之间距离
int base = 3;  // 进制，似乎最多只能支持36进制，基数更大会按照十进制处理
int offset = 0;  // 数值从这里开始一帧加1
int n0 = offset;  // 当前图上对应数值最小值，不可能小于offset
int n1 = offset;  // 当前图上对应数值最大值
float[] colorArray = new float[base];  // 对应颜色数组
String s;  //把十进制数值转换成指定进制字符串
String frameName;  // 保存的图片名称
boolean r = true;
float c = 0;
color backgroundColor = int(random(255));
void setup() {
  smooth();
  noStroke();
  size(400, 800);
  background(backgroundColor);
  println("背景颜色:", backgroundColor);
  frameRate(10000);  // 设置合适的更新速度。如果想看动态刷新效果，格子小则设置较快的更新速度，格子大则设置较慢的更新速度。更新太快会一闪而过，更新太慢考验耐心。如果只想保存图形，则设置较大的值，但是最好不要在格子太大的情况下同时设置太快的更新速度，以免一次保存太多图形。
  for (int a = 0; a < base; a++) {
    colorArray[a] = random(256);
  }
  println(colorArray);
}
void draw() {
  s = Integer.toString(n1, base);
  if (cellHeight * (d + 1) > height) {
    d -= height/cellHeight;
    b += distance;
    if (cellWidth * (b + distance) > width) {
      b = 0;
    }
    //background(255);
  }
  n0 = max(offset, frameCount + offset - (height/cellHeight) * max(1, width/distance/cellWidth));
  int l = min(s.length(), maxNumber, distance);
  for (int x = 0; x < l; x++) {
    char c1 = s.charAt(s.length() - x - 1);
    if (48 <= int(c1) && int(c1) <= 57) {
      c = colorArray[int(c1) - 48];
    } else {
      if (97 <= int(c1) && int(c1) <= 122) {
        c = colorArray[int(c1) - 87];
      }
    }
    fill(c);
    rect(cellWidth*(x+b), d * cellHeight, cellWidth, cellHeight);
  }
  frameName = String.format("黑和白的舞蹈_随机第三颜色_大小%dx%d_格子尺寸%dx%d_%d进制_数字范围%d到%d_背景颜色%d.png", width/cellWidth, height/cellHeight, cellWidth, cellHeight, base, n0, frameCount + offset - 1, backgroundColor);
  if (b >= (width / cellWidth - (width / cellWidth) % distance) - distance && d == height / cellHeight - 1) {
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
void keyPressed() {
  switch (key) {
    case '1':
      for (int a = 0; a < base; a++) {
        colorArray[a] = random(256);
      }
      println(colorArray);
      break;
  }
}
