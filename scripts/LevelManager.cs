using Godot;
using System;

namespace levelManagment {

public partial class LevelManager : Node3D
{
	[Export] PackedScene NextLevel;
	public override void _Ready()
	{

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}

	public void LoadNextLevel() {
		GetTree().ChangeSceneToPacked(NextLevel);
	}
}

}