extends Camera2D

@export var speed = 25

@onready var character = $"../MainCharacter"
@onready var rock_spawner = $"../RockSpawner"
@onready var rock_spawner_y_position = $SpawnerYPosition

var highscore = preload("res://highscore.tscn")

var heightLimit = 179
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.global_position =  Vector2(0, -heightLimit) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.DOWN * speed * delta
	move_rock_spawner()
	
func move_rock_spawner():
	rock_spawner.position.x = character.position.x
	rock_spawner.position.y = rock_spawner_y_position.global_position.y

#func _on_timer_timeout() -> void:
	#$"../CanvasLayer".visible = true
