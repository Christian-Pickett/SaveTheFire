extends RigidBody2D

var direction
var lifespan = 30

func _ready():
	direction = Global.Player.direction
	self.rotate(Global.Player.rotato)
	self.position.x = Global.Player.position.x + (direction.x * 10)
	self.position.y = Global.Player.position.y + (direction.y * 10)
	self.linear_velocity = direction * 1000

func _process(delta):
	lifespan = lifespan - 1
	if lifespan == 0:
		queue_free()