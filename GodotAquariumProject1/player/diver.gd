extends Node2D

const KICK_IMPULSE: float = 2
const WATER_DRAG: float = 0.02

var moving: bool = false
var velocity: Vector2
var target_pos: Vector2
var ghost_sprite: Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $DiverSprite

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	#detect the mouse input event that will choose a new destination
	if event is InputEventMouseButton:
		if not event.pressed and event.button_index == 2:
			print("set new destination")
			target_pos = get_global_mouse_position()
			set_new_direction(target_pos)

func _process(delta: float) -> void:
	
	#keep the diver moving
	if moving:
		velocity *= 1 - WATER_DRAG
		position += velocity
		
		#stop the movement if the diver is near their target
		if position.distance_to(target_pos) < 10:
			moving = false
			ghost_sprite.queue_free()
			animation_player.play("idle")

func set_new_direction(destination: Vector2):
	
	#create a ghost to indicate target position
	if ghost_sprite != null:
		ghost_sprite.queue_free()
	ghost_sprite = Sprite2D.new()
	ghost_sprite.texture = sprite.texture
	ghost_sprite.modulate = Color(1,1,1,0.3)
	ghost_sprite.position = target_pos
	ghost_sprite.hframes = 2
	get_parent().add_child(ghost_sprite)
	
	#orient diver towards the new destination
	var diver_rotation: float = position.angle_to_point(destination)
	sprite.rotation = diver_rotation
	if position.x - destination.x > 0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	
	#set new velocity with an initial kick
	velocity = position.direction_to(destination) * KICK_IMPULSE
	
	#turn on moving to enable the process function
	moving = true
	
	#activate the swimming state of the animation player
	animation_player.play("swim")

func kick():
	
	#this will be called by the animation player when the kick frame is active
	velocity = velocity.normalized() * KICK_IMPULSE
