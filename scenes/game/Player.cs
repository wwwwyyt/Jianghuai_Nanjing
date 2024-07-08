using Godot;
using System;

public partial class Player : Area2D
{
    // 初始化 
    // 移动速度（初始值为零向量）
    private Vector2 Velocity = Vector2.Zero;
    
    // 移动速率（可以在Godot检查器界面修改）
    [Export]
    public int Speed { get; set; }
    
    // 屏幕大小（限制活动范围）
    private Vector2 ScreenSize;
    public override void _Ready()
    {
        ScreenSize = GetViewportRect().Size; // 获取屏幕大小
        Speed = 400;
        Start();
    }

    // 处理开始新游戏（玩家的初始状态）
    public void Start()
    {
        // 设置玩家起始位置
        Vector2 initPosition; initPosition.X = 350; initPosition.Y = 700;
        Position = initPosition;

        // 设置玩家起始朝向
        Rotation = 0.0f;

        // 设置碰撞检测开启
        GetNode<CollisionShape2D>("CollisionShape2D").SetDeferred(CollisionShape2D.PropertyName.Disabled, false);

        // 显示玩家
        Show();
    }

    // 处理键盘输入的函数
    public void GetInput()
    {
        Vector2 inputDirection = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
        Velocity = inputDirection * Speed;
    }
    public override void _PhysicsProcess(double delta)
    {
        // 处理输入和运动
        GetInput();
        Position += Velocity * (float)delta;
        Position = new Vector2(
            x: Mathf.Clamp(Position.X, 0, ScreenSize.X),
            y: Mathf.Clamp(Position.Y, 0, ScreenSize.Y)
        );
    }
}
