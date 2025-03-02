@tool
extends Linked_State


# To exit call transition_to_next_states()

# Fill all the slots in here and not in the linked states only fill the first idle state there and don't fill next states
@export var all_slots:Array[State_carrior]:
	set(value):
		all_slots = value
		if !all_slots.is_empty() and !is_instance_valid(all_slots[all_slots.size()-1]):
			all_slots[all_slots.size()-1] = State_carrior.new()

# Change this to the type of direct Input you want to receive it will be used to directly travel to a particular state. Like direct access to primary weapon by pressing key 1.
@export var inputs: Array[Key]

func state_initiate()->void:
	setup_state_carriers(all_slots)

func Enter()->void:
	pass

func Exit()->void:
	pass

func Update(_delta: float)->void:
	pass

func Physics_Update(_delta:float)->void:
	pass

func state_input(_event: InputEvent)->void:
	if _event is InputEventKey and !active_states.is_empty():
		var key_index: int = inputs.find(_event.keycode)
		if key_index+1 and all_slots[key_index].Ref != active_states[0].Ref:
			active_states[0].Ref.next_states = [all_slots[key_index]]
			active_states[0].Ref.delayed_Exit()
