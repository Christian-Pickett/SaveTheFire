extends CanvasLayer

func _process(delta):
	$Wood.value = Global.Player.wood * (3.3333)
	$Fire.value = Global.Campfire.scale.x * 100
