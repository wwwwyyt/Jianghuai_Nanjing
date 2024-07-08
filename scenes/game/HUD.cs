using Godot;
using System;

public partial class HUD : CanvasLayer
{
    public override void _Process(double delta)
    {
        // fps Label
        Label fps = GetNode<Label>("fps");
        fps.Text = Engine.GetFramesPerSecond().ToString("F1") + " fps";
    }
}
