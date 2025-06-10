using Godot;
using System;

namespace levelManagment {

public partial class WorldManager : Node3D
{
	[Export] PackedScene FirstLevel;
		public override void _Ready()
		{
			AddChild(FirstLevel.Instantiate());
		}
}

}