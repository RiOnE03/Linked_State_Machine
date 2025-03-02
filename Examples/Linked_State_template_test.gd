@tool
extends Linked_State


# To exit call transition_to_next_states()
@export var keycode: Key
func state_initiate()->void:
	pass

func Enter()->void:
	pass

func Exit()->void:
	pass

func Update(_delta: float)->void:
	pass

func Physics_Update(_delta:float)->void:
	pass

func state_input(_event: InputEvent)->void:
	if _event is InputEventKey:
		if _event.keycode == keycode:
			print("key: " + _event.as_text_keycode())
			transition_to_next_states()
