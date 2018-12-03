extends Area2D

signal Splash

func _ready():
	find_start_pos()
	$AnimatedSprite.play("Fly")
	self.connect("Splash", get_parent().find_node("Campfire"), "_on_Splash")


func _process(delta):
	
	if self.position.x > 1340:
		self.position.x += -1
	elif self.position.x < 1340:
		self.position.x = self.position.x + 1
	elif self.position.y > 1370:
		self.position.y += -1
	elif self.position.y < 1370:
		self.position.y = self.position.y + 1

	if self.position.x == 1340 && self.position.y == 1370:
		emit_signal("Splash")
		Dies()

func _on_RainBee_body_entered(body):
	Dies()
	
func Dies():
	$AnimatedSprite.play("Die")
	$DeathFart.play()
	$Timer.start()

func _on_Timer_timeout():
	var forest = self.get_parent()
	var newBaby = preload("res://Scenes/RainBeetle.tscn").instance()
	
	forest.add_child(newBaby)
	queue_free()

func find_start_pos():
	var start
	var positions = get_parent().find_node("Spawns")
	var selection = positions.get_children()
	
	randomize()
	start = randi() % 4
	self.position = selection[start].position
