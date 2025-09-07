extends "res://projectiles/player_projectile.gd"

func _set_ticks_until_max_range() -> void:
	._set_ticks_until_max_range()
	_ticks_until_max_range = int(_ticks_until_max_range / Engine.time_scale)
