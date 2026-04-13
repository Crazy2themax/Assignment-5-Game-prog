extends CharacterBody2D
@onready var animatedSprite = $AnimatedSprite2D
@onready var spawner = $"../Camera2D/FloorSpawner"
@onready var player = $"."
@onready var dammage = $"../AudioStreamPlayer"

signal health_changed(new_health: int)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TILE_SIZE = 32

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right = true
var is_dead = false
var is_hurt = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _process(delta):
	animate()
	flip()
	var depth = current_depth()
	Global.update_depth(depth)

func animate():
	if is_dead:
		return
	if is_hurt:
		return
	if not is_on_floor():
		animatedSprite.play("jump")
	elif abs(velocity.x) > 0.05:
		animatedSprite.play("run")
	else:
		animatedSprite.play("idle")

func flip():
	if velocity.x < -0.5 and is_facing_right:
		scale.x *= -1
		is_facing_right = false
	if velocity.x > 0.5 and not is_facing_right:
		scale.x *= -1
		is_facing_right = true

func take_damage():
	if is_hurt:
		return
	if is_dead:
		return
	Global.health -= 1
	emit_signal("health_changed", Global.health)
	dammage.play()
	if Global.health <= 0:
		death()
		return
	is_hurt = true
	animatedSprite.play("hurt") 
	_flash_red()                              # flash runs independently in background
	await get_tree().create_timer(1.0).timeout
	is_hurt = false
	modulate = Color.WHITE
	
	

func _flash_red():
	for i in range(15):
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color(1, 1, 1, 0.3)
		await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.death()
		

func death():
	if is_dead:
		return
	is_dead = true
	print("player died")
	animatedSprite.play("death")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func current_depth():
	return int(($Feet.global_position.y - spawner.start_y) / TILE_SIZE) +1
