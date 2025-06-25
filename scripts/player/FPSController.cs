using Godot;
using System;

// Responsible for applying velocity to Player's CharacterBody3D node and handling camera rotation.
public partial class FPSController : Node
{
	[Export] public CharacterBody3D MyCharacterBody {get; set;}
	[Export] public Node3D HorizontalDirAxis {get; set;}
	[Export] public Node3D VerticalDirAxis {get; set;}
	[Export] public float Speed = 7.0f;
	[Export] public float Sensitivity = 0.002f;
	[Export] public float JumpVelocity = 4.5f;
	bool enableCameraControl = true;
	bool enableCharacterBodyControl = true;
	// Called when player character begins to respond to a phrasebox
	public void OnBeginResponse()
	{
		enableCameraControl = false;
		enableCharacterBodyControl = false;
		Input.MouseMode = Input.MouseModeEnum.Visible;
	}
	// Called when player character has stopped responding to a phrasebox
	public void OnEndResponse()
	{
		enableCameraControl = true;
		enableCharacterBodyControl = true;
		Input.MouseMode = Input.MouseModeEnum.Captured;
	}
	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/3d/default_gravity").AsSingle();
	public override void _Ready()
    {
		Input.MouseMode = Input.MouseModeEnum.Captured;
    }
	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseMotion && enableCameraControl)
		{
			InputEventMouseMotion mouseEvent = @event as InputEventMouseMotion;
			VerticalDirAxis.RotateX(-mouseEvent.Relative.Y * Sensitivity);
			HorizontalDirAxis.RotateY(-mouseEvent.Relative.X * Sensitivity);
		}
    }
	public override void _PhysicsProcess(double delta)
	{
		Vector3 velocity = MyCharacterBody.Velocity;

		// Add the gravity.
		if (!MyCharacterBody.IsOnFloor())
			velocity.Y -= gravity * (float)delta;

		// Handle Jump.
		if (Input.IsActionJustPressed("ui_accept") && MyCharacterBody.IsOnFloor() && enableCharacterBodyControl)
			velocity.Y = JumpVelocity;

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		Vector2 inputDir = Input.GetVector("move_left", "move_right", "move_forward", "move_backward");
		Vector3 direction = HorizontalDirAxis.Transform.Basis * new Vector3(inputDir.X, 0, inputDir.Y);
		if (direction != Vector3.Zero && enableCharacterBodyControl)
		{
			velocity.X = direction.X * Speed;
			velocity.Z = direction.Z * Speed;
		}
		else
		{
			velocity.X = Mathf.MoveToward(MyCharacterBody.Velocity.X, 0, Speed);
			velocity.Z = Mathf.MoveToward(MyCharacterBody.Velocity.Z, 0, Speed);
		}

		MyCharacterBody.Velocity = velocity;
		MyCharacterBody.MoveAndSlide();
	}
}
