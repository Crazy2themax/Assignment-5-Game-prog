extends Node

var depth = 0
var highscore = 0
var health = 4

signal depth_changed(new_depth)
signal highscore_changed(new_highscore)

func update_depth(new_depth: int):
	# Only update if the player reached a new maximum depth this run
	if new_depth > depth:
		depth = new_depth
		emit_signal("depth_changed", depth)

		# Update highscore if needed
		if depth > highscore:
			highscore = depth
			emit_signal("highscore_changed", highscore)
