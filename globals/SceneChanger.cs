using Godot;
using System;

public partial class SceneChanger : Node
{
    public static SceneChanger Instance { get; private set; }
    public Node CurrentScene { get; set; }
    public override void _Ready()
    {
        Instance = this;

        Viewport root = GetTree().Root;
        CurrentScene = root.GetChild(root.GetChildCount() - 1);
    }
    public void GotoScene(string path)
    {
        CallDeferred(MethodName.DeferredGotoScene, path);
    }
    public void DeferredGotoScene(string path)
    {
        CurrentScene.Free();
        var nextScene = GD.Load<PackedScene>(path);
        CurrentScene = nextScene.Instantiate();
        GetTree().Root.AddChild(CurrentScene);
        GetTree().CurrentScene = CurrentScene;
    }
}
