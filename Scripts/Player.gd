extends KinematicBody2D

const SPEED = 20
const MAX_SPEED = 400
const FRICTION = 0.1

signal Stoke_fire

var motion = Vector2()
var velocity_multiplier = 1
var direction = Vector2()
var rotato
var wood = 30

func _ready():
	Global.Player = self
	self.connect("Stoke_fire", get_parent().find_node("Campfire"), "_on_Stoke_fire")

func _process(delta):
	update_motion(delta)
	move_and_slide(motion * velocity_multiplier)
	if motion.x > 3 || motion.x < -4 || motion.y > 4 || motion.y < -4:
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")

func update_motion(delta):
	#horizontal movement
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		if not (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
			motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED)
		else:
			motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED * (1/sqrt(2)))

	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		if not (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
			motion.x = clamp((motion.x - SPEED), -MAX_SPEED, 0)
		else:
			motion.x = clamp((motion.x - SPEED), -MAX_SPEED * (1/sqrt(2)), 0)

	else:
		motion.x = lerp(motion.x, 0, FRICTION)
		
	
	#vertical movement
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			motion.y = clamp((motion.y - SPEED), -MAX_SPEED, 0)
		else:
			motion.y = clamp((motion.y - SPEED), -MAX_SPEED * (1/sqrt(2)), 0)

	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			motion.y = clamp((motion.y + SPEED), 0, MAX_SPEED)
		else:
			motion.y = clamp((motion.y + SPEED), 0, MAX_SPEED * (1/sqrt(2)))
	else:
		motion.y = lerp(motion.y, 0, FRICTION)

	if Input.is_action_pressed("ui_select") && wood > 0 && $Timer.is_stopped():
		$Timer.start()
		wood = wood -1
		emit_signal("Stoke_fire")

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if $Timer.is_stopped() and wood > 0:
			wood = wood - 1
			shoot_arrow()

func shoot_arrow():
	var forest = self.get_parent()
	var arrow = preload("res://Scenes/Arrow.tscn").instance()
	$Timer.start()
	rotato = self.get_angle_to(get_global_mouse_position())
	direction.x = cos(rotato)
	direction.y = sin(rotato)
	forest.add_child(arrow)

func _on_Deadzone_body_entered(body):
	if body.name == "RainBee" || body.name == "TreeMonster":
		get_tree().change_scene("res://Scenes/GameOver.tscn")
