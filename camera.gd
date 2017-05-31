extends Camera2D

var velocity = Vector2(0,5)
var scroll_speed = -100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	velocity.y += scroll_speed * delta
	set_offset(velocity)