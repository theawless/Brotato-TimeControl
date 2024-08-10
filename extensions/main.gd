extends "res://main.gd"


func _input(event: InputEvent) -> void:
	._input(event)
	if not event is InputEventKey:
		return
	if not event.pressed:
		return
	var wave_data = ZoneService.get_wave_data(RunData.current_zone, RunData.current_wave);
	if event.scancode == KEY_J:
		_wave_timer.start(max(_wave_timer.time_left - 1, 0))
		_wave_manager.init(_wave_timer, wave_data)
	if event.scancode == KEY_K:
		_wave_timer.start(0.01)
		_wave_manager.init(_wave_timer, wave_data)
	if event.scancode == KEY_L:
		_wave_timer.start(min(_wave_timer.time_left + 1, wave_data.wave_duration))
		_wave_manager.init(_wave_timer, wave_data)
	if event.scancode == KEY_I:
		Engine.time_scale = max(0, Engine.time_scale - 0.1)
	if event.scancode == KEY_O:
		Engine.time_scale = 1
	if event.scancode == KEY_P:
		Engine.time_scale = min(10, Engine.time_scale + 0.1)
