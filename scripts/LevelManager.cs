using Godot;
using System;

namespace levelManagment {

public partial class LevelManager : Node3D
{
	[Export] PackedScene NextLevel;

	public void LoadNextLevel() {
		GetTree().ChangeSceneToPacked(NextLevel);
	}
}

}