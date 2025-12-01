# sketches_black_white 黑和白的舞蹈

整数转二进制，在只有 0 和 1 的情况下，能画出什么图形？不同进制呢？先把整数代入数学公式再转不同进制呢？

## 目前代码

### 黑和白的舞蹈 black_white

把整数转二进制，水平翻转，一个数字画出一行格子
1 对应黑色格子，0 对应白色格子

整个代码仓库最基础的部分。

### 第三进制 base_3_black_white

把整数转不同进制，为了保持黑白风格不变，把各数码替换成0和1，再画图。

就是后面多次出现的“转换”。

### 不同效果 transformation_black_white

黑白互换，把原来竖着画的图形横着画，原来一行一行刷新的画图方式变成一次画满整张图，有什么不同效果？

即互补，转置，静态图形。

### 第三颜色系列 color_3_black_white

把整数转不同进制，保留各数码值，改用不同灰色。

附带一些互补转置效果。

### 数学公式 math_black_white

先把整数代入数学公式算出值，再后续处理，又能画出什么图形？

目前有一次函数，二次函数，幂函数，指数函数。

### 嵌套系列 nested_black_white

对一个整数多次转换，能画出什么图形？

目前最复杂的代码。

### black_white_2d 

把黑和白的舞蹈拓展到 x、y 两个方向上

## 关于Processing

Processing 是一种开源的编程语言，也是一个开发环境，与多种常见的编程语言的区别是，输入代码就能直接画出各种想要的图形。默认 Java 模式。详见官网：[https://processing.org](https://processing.org)

根据其项目地址 [https://github.com/processing/processing4](https://github.com/processing/processing4)，Processing 4 的许可证信息：

- 核心库遵循 [LGPLv2.1](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html) 许可证
- Processing 开发环境遵循 [GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) 许可证

如果只是用 Processing 作为工具创作的代码，一般可以自由选择许可证

## 运行环境

建议使用 `Processing 4.3.2` 或更高版本。没有在其他版本上测试，不保证能在每个版本上正常运行。

Processing 最新版本下载地址：[https://processing.org/download](https://processing.org/download)

下载特定版本：[https://github.com/processing/processing4/releases](https://github.com/processing/processing4/releases)

## 运行方式

用 Git 克隆仓库：

```bash
git clone git@github.com:qp91mn64/sketches_black_white.git
```

或者点击绿底白字的 Code 按钮，选择 Download ZIP，下载zip文件，自行解压。

代码经过整理，详见各二级目录的 `README.md` 和代码里的说明。

一般而言，任选一份 `.pde` 文件，用 `Processing IDE` 打开即可运行。

注意两个地方：
- 刷新帧率 `frameRate()` 默认很大，实际极有可能达不到这个速度，而且因电脑配置而异，自行调整；
- 画布尺寸 `size()` ，部分代码默认尺寸较大，如果显示器分辨率不够，例如 800 x 600，可能会导致显示不完，应该不至于影响到保存的图片，想完整显示的也请先自行调整。

所有的示例图形都是 `.png` 格式的，常见的图片查看器就能查看，但是可能不利于观察细节。也可以用画图软件查看。

能保存图形，只是默认图片名称很长，包含了复现图形所需参数。保留图片名称中的参数信息不是必须，只是不同参数有可能画出风格迥异的图片，如果你去掉了参数信息，万一后面你，或者，看到这张图片的其他人，想知道怎么画出来的，却不知道怎么调参数，试了半天，迷失在无穷无尽的参数组合中呢？

## 许可证

本代码仓库采用MIT许可证。详见 [LICENSE](LICENSE)。
