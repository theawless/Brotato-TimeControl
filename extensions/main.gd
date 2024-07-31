extends "res://main.gd"


func _input(event: InputEvent) -> void:
	._input(event)
	if not event is InputEventKey:
		return
	if not event.pressed:
		return
	if event.scancode == KEY_K:
		_wave_timer.start(0.01)
	if event.scancode == KEY_L:
		var wave_data = ZoneService.get_wave_data(RunData.current_zone, RunData.current_wave);
		_wave_timer.start(min(_wave_timer.time_left + 1, wave_data.wave_duration))
	if event.scancode == KEY_J:
		_wave_timer.start(max(_wave_timer.time_left - 1, 0))
