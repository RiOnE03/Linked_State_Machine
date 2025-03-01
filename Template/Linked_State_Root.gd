@tool
class_name Linked_State_Root extends Node


@export var linked_states: Array[State_carrior]:
	set(value):
		linked_states = value
		if !is_instance_valid(linked_states[linked_states.size()-1]):
			linked_states[linked_states.size()-1] = State_carrior.new()

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
		state_initiate()

func state_initiate()->void:
	pass

func activate_states(states: Array[State_carrior])->void:
	for state_carrior in states:
		if is_instance_valid(state_carrior.Ref):
			state_carrior.Ref.start_state(self,state_carrior.control,state_carrior.start_fresh)

func deactive_states(states: Array[State_carrior])->void:
	for state_carrior in states:
		if is_instance_valid(state_carrior.Ref):
			state_carrior.Ref.end_state(self)


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
