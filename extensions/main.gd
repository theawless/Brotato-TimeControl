extends "res://main.gd"

var _key_pressed = {
	KEY_MINUS: false,
	KEY_EQUAL: false,
	KEY_BRACKETLEFT: false,
	KEY_BRACKETRIGHT: false,
	JOY_L: false,
	JOY_L2: false,
	JOY_R: false,
	JOY_R2: false,
}

func _input(event: InputEvent) -> void:
	._input(event)

	if event is InputEventKey and event.scancode in _key_pressed:
		_key_pressed[event.scancode] = event.pressed
	elif event is InputEventJoypadButton and event.button_index in _key_pressed:
		_key_pressed[event.button_index] = event.pressed
	else:
		return

	var slower = _key_pressed[KEY_MINUS] or _key_pressed[JOY_L]
	var faster = _key_pressed[KEY_EQUAL] or _key_pressed[JOY_R]
	var decrease = _key_pressed[KEY_BRACKETLEFT] or _key_pressed[JOY_L2]
	var increase = _key_pressed[KEY_BRACKETRIGHT] or _key_pressed[JOY_R2]

	if slower and faster:
		Engine.time_scale = 1
	elif slower:
		Engine.time_scale = max(0, Engine.time_scale - 0.1)
	elif faster:
		Engine.time_scale = min(10, Engine.time_scale + 0.1)

	var wave_data = ZoneService.get_wave_data(RunData.current_zone, RunData.current_wave);

	if decrease and increase:
		_wave_timer.start(0.01)
		_wave_manager.init(_wave_timer, wave_data)
	elif decrease:
		_wave_timer.start(max(_wave_timer.time_left - 1, 0))
		_wave_manager.init(_wave_timer, wave_data)
	elif increase:
		_wave_timer.start(min(_wave_timer.time_left + 1, wave_data.wave_duration))
		_wave_manager.init(_wave_timer, wave_data)
