extends KinematicBody2D

var direction = Vector2()
var HP = 60
var onFire = false

func _ready():
	add_to_group("Tree_Monster")
	$AnimatedSprite.play("noFire")

func _process(delta):
	direction.x = cos(self.get_angle_to(Global.Player.position))
	direction.y = sin(self.get_angle_to(Global.Player.position))
	move_and_slide(direction * 100)
	if onFire:
		burn()

func scream():
	$Screaming.play()

func burn():
	onFire = true
	$AnimatedSprite.play("onFire")
	if HP != 0:
		if $Timer.is_stopped():
			HP = HP - 1
			$Timer.start()
	else:
		queue_free()
		get_tree().change_scene("res://Scenes/Victory.tscn")

func douse():
	onFire = false
	$AnimatedSprite.play("noFire")

