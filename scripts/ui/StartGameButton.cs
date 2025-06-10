using Godot;
using System;

public partial class StartGameButton : Button
{
	public override void _Ready()
	{
		Pressed += () => GetTree().ChangeSceneToFile("res://scenes/levels/EmptyWorld.tscn");
	}
}
