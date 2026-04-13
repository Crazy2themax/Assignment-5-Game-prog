extends CharacterBody2D
@onready var animatedSprite = $AnimatedSprite2D
@onready var spawner = $"../Camera2D/FloorSpawner"
@onready var player = $"."
@onready var dammage = $"../AudioStreamPlayer"
signal health_changed(new_health: int)

var highscore = Global.highscore

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TILE_SIZE = 32
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right = true
var is_dead = false
var is_hurt = false
var flash_tween: Tween
var is_invincible = false

func _physics_process(delta):
	if is_dead:
		velocity = Vector2.ZERO
		move_and_slide()
		return
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
	if is_hurt:  # only blocks during the short hurt animation
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
	if is_invincible or is_dead:
		return
	Global.health -= 1
	Global.update_health(Global.health)
	dammage.play()
	if Global.health <= 0:
		death()
		return
	# Start invincibility immediately
	is_invincible = true
	# Play hurt animation once
	is_hurt = true
	animatedSprite.play("hurt")
	await animatedSprite.animation_finished
	is_hurt = false
	# Flash for 3 seconds
	flash_red()
	await get_tree().create_timer(3.0).timeout
	# End invincibility
	is_invincible = false
	if flash_tween and flash_tween.is_valid():
		flash_tween.kill()
	modulate = Color.WHITE

func flash_red():
	if flash_tween and flash_tween.is_valid():
		flash_tween.kill()
	flash_tween = create_tween()
	flash_tween.set_loops(15)
	flash_tween.tween_property(self, "modulate", Color.RED, 0.1)
	flash_tween.tween_property(self, "modulate", Color(1, 1, 1, 0.3), 0.1)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.death()

func death():
	if is_dead:
		return
	is_dead = true
	if flash_tween and flash_tween.is_valid():
		flash_tween.kill()
	modulate = Color.WHITE
	animatedSprite.play("death")
	await get_tree().create_timer(2.0).timeout
	SceneManager.change_scene("res://Scenes/game_over.tscn", {
		"pattern" :"res://addons/scene_manager/shader_patterns/vertical.png" ,
		"speed": 6,
		"color" : Color.DARK_RED
	})

func current_depth():
	return int(($Feet.global_position.y - spawner.start_y) / TILE_SIZE) +1
