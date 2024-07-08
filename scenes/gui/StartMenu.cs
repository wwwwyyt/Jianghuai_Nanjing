using Godot;
using System;

public partial class StartMenu : Control
{
    public void OnGameStartBtnPressed()
    {
        SceneChanger.Instance.GotoScene("res://scenes/game/Level.tscn");
    }
}
