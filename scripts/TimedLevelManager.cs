using Godot;
using System;

namespace levelManagment {

public partial class TimedLevelManager : LevelManager
{
    [Export] private float delay = 5f;
	public override void _Ready()
	{
        base._Ready();
        GetTree().CreateTimer(delay).Timeout += LoadNextLevel;
	}
}

}