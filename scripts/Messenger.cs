using Godot;
using System;
// using [Insert external module here - email service API library]

public partial class Messenger : Node
{
  [Export]
  public String hostPhoneNumber;

  [Export]
  public String receiverPhoneNumber;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
