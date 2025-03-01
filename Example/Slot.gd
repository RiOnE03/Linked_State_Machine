@tool
extends Linked_State


# To exit call transition_to_next_states()


@export var adjacent_right_state: State_carrior = State_carrior.new()
@export var adjacent_left_state: State_carrior = State_carrior.new()
@export var Enter_delay: float
@export var Exist_Delay: float


var can_call_delay:bool = true


func carrier_filter(value:Array[State_carrior])->State_carrior: 
	return null if value.is_empty() else value[0]

func state_initiate()->void:
	adjacent_right_state = carrier_filter(setup_state_carriers([adjacent_right_state]))
	adjacent_left_state = carrier_filter(setup_state_carriers([adjacent_left_state]))

func Enter()->void:
	can_call_delay = false
	print("Entered Key state: " + name)
	# do stuff upon enter like play the inital animation
	await get_tree().create_timer(Enter_delay).timeout
	can_call_delay = true

func Exit()->void:
	print("Exited Key state: " + name)

func Update(_delta: float)->void:
	pass

func Physics_Update(_delta:float)->void:
	pass


func delayed_Exit()->void:
	if can_call_delay:
		can_call_delay = false
		#play exist animation or sort
		await get_tree().create_timer(Exist_Delay).timeout
		transition_to_next_states()
		can_call_delay = true

func state_input(_event: InputEvent)->void:
	if _event is InputEventMouseButton:
		if _event.button_index == MOUSE_BUTTON_WHEEL_UP and _event.pressed:
			next_states = [adjacent_right_state]
			get_viewport().set_input_as_handled()
			delayed_Exit()
		elif _event.button_index == MOUSE_BUTTON_WHEEL_DOWN and _event.pressed:
			next_states = [adjacent_left_state]
			get_viewport().set_input_as_handled()
			delayed_Exit()
