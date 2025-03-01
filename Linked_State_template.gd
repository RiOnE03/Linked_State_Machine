@tool
extends Linked_State


# To exit call transition_to_next_states()


# To create and use more state carriors follow this syntax:
# For array of carriers:
# 		setup_state_carriers(new_carriers)
# For single carrier:
#		func carrier_filter(value:Array[State_carrior])->State_carrior: 
#			return null if value.is_empty() else value[0]
#		carrier = carrier_filter(setup_state_carriers([carrier]))
# and use this in state_initiate()

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
	pass
