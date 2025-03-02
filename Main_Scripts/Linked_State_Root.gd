@tool
## The base class for Linked State Machine and the root of all the states. This class only acts as the last point for the propogation of transition signal and do not process anything. It will directly transition the states to their next states.
## Some of the properties also do not work with this class such as FULL_LINK_CONTINUE and FULL_LINK_RESET works the same since they only work for the time of initiation and then the 
## process of the state activations depends on the passing states themselves. States themselves will then be responsible for deciding the next states situation. 
class_name Linked_State_Root extends Node


## The linked states that will start along with the current states if the control type is not Isolated for the current state.
@export var linked_states: Array[State_carrior]:
	set(value):
		linked_states = value
		if !linked_states.is_empty() and !is_instance_valid(linked_states[linked_states.size()-1]):
			linked_states[linked_states.size()-1] = State_carrior.new()

## State_carriers are not perfect and needs to be setup before using them. Make sure to set them up in ready or state_initiate using this method.
func setup_state_carriers(carriars: Array[State_carrior])->Array[State_carrior]:
	if not Engine.is_editor_hint():
		for carriar in carriars:
			var s: Linked_State = get_node(carriar.state)
			carriar.Ref = s
			if s.is_always_active:
				carriars.erase(carriar)
	return carriars

func _ready():
	if not Engine.is_editor_hint():
		setup_state_carriers(linked_states)
		activate_states(linked_states)


## Starts all the states given in the form of state carrier's Array
func activate_states(states: Array[State_carrior])->void:
	for state_carrior in states:
		if is_instance_valid(state_carrior.Ref):
			state_carrior.Ref.start_state(self,state_carrior.control)

## Stops all the states given in the form of state carrier's Array
func deactive_states(states: Array[State_carrior])->void:
	for state_carrior in states:
		if is_instance_valid(state_carrior.Ref):
			state_carrior.Ref.end_state(self)

## The internal function used for transitioning the linked states to their next states
func process_states(sender_state:Linked_State):
	for child in linked_states:
		if child.Ref==sender_state:
			if child.can_trigger_out:
				deactive_states(linked_states)
				linked_states.clear()
			else:
				linked_states.erase(child)
				sender_state.end_state(self)
			break
	linked_states.append_array(sender_state.next_states)
	activate_states(sender_state.next_states)
