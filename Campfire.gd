extends Area2D

func _ready():
	Global.Campfire = self

func _process(delta):
	if self.scale.x > .001:
		self.scale.x = self.scale.x - .0005
		self.scale.y = self.scale.y - .0005
	else:
		get_tree().change_scene("res://Scenes/GameOver.tscn")


func _on_Campfire_body_entered(body):
	if body.name == "TreeMonster":
		get_tree().call_group("Tree_Monster", "burn")
		get_tree().call_group("Tree_Monster", "scream")

func _on_Campfire_body_exited(body):
	if body.name == "TreeMonster":
		get_tree().call_group("Tree_Monster", "douse")

func _on_Stoke_fire():
	if $Timer.is_stopped():
		$Timer.start()
		$Stoke.play()
		self.scale.x = self.scale.x + .7
		self.scale.y = self.scale.y + .7

func _on_Splash():
	self.scale.x = self.scale.x - .2
	self.scale.y = self.scale.y - .2
