# 项目结构

![项目结构](E:\My Projects\Godot\2-4 江淮Project - 南京\doc\项目结构.png)

# 游戏功能

菜单界面：

- Game Start：开始**全流程**的游戏
- Practice Start：选择某一关卡进行游戏，相当于练习
- Score：分数记录
- Replay Mode(?)：加载某一关卡的操作记录，相当于游戏回放
- Music Room(?)：播放游戏音乐（但我没有什么音乐）
- Option：游戏设置
- Quit：退出游戏，要加上询问对话框

弹幕射击游戏的特点是线性关卡，固定内容，这一点如同一部音乐专辑，是**情感的流露**。

# 弹幕设计

弹幕的本质其实是CollisionBody2D。因此它应该包括各种几何形状和移动方式。

我将它的移动方式简化为：

- 从一点到另一点的匀速直线运动
- 顺某一点按某一半径做顺时针或逆时针的匀速圆周运动
- 按物理规律施加某个方向的恒力所做的匀加速运动

## 参数

通用参数

- 色彩（Vector2）
- 形状（Polygon2D）：使用PackedVector2Array初始化
- 碰撞体（CollisionPolygon2D）：使用PackedVector2Array初始化
- 单个子弹移动时间 （float）或者移出视口自动销毁
- 这个子弹生成到下一个子弹生成的时间间隔（float）
- 是否会被子弹销毁（bool）

匀速直线运动

- 起点（Vector2）
- 终点（Vector2）

匀速圆周运动

- 圆心（Vector2）
- 半径（int）

匀加速运动

- 起点（Vector2）

- 力（Vector2）