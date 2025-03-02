@tool
class_name Linked_State extends Linked_State_Root

@export var next_states:Array[State_carrior]:
	set(value):
		next_states = value
		if !next_states.is_empty() and !is_instance_valid(next_states[next_states.size()-1]):
			next_states[next_states.size()-1] = State_carrior.new()

@export var is_always_active: bool = false:
	set(value):
		is_always_active = value
		notify_property_list_changed()

var control_state: State_carrior.control_type


var active_states: Array[State_carrior]

var is_active: bool = false
var caller: Linked_State_Root


#region

func _get_property_list() -> Array[Dictionary]:
	var properties:Array[Dictionary]
	if is_always_active:
		properties.append(
			{
				"name" = "control_state",
				"type" = TYPE_INT,
				"hint" = PROPERTY_HINT_ENUM,
				"hint_string" = ",".join(State_carrior.control_type.keys())
			}
		)
	return properties

func _process(delta: float) -> void:
	if is_active:
		Update(delta)

func _physics_process(delta: float) -> void:
	if is_active:
		Physics_Update(delta)

func _input(event: InputEvent) -> void:
	if is_active:
		state_input(event)


func activate_states(states: Array[State_carrior])->void:
	for state_carrior in states:
		if is_instance_valid(state_carrior.Ref):
			state_carrior.Ref.start_state(self,state_carrior.control)
			if active_states.find(state_carrior)==-1:
				active_states.append(state_carrior)

#endregion


func _ready() -> void:
	if not Engine.is_editor_hint():
		is_active = is_active or is_always_active
		setup_state_carriers(linked_states)
		setup_state_carriers(next_states)
		if is_always_active:
			start_state(self,control_state)
		state_initiate()



func start_state(caller_Ref: Linked_State_Root, Mode: State_carrior.control_type)->void:
	if caller == caller_Ref or is_always_active: return
	caller = caller_Ref
	if is_active:
		if Mode == State_carrior.control_type.FULL_LINK_RESET:
			deactive_states(active_states)
			active_states.clear()
			activate_states(linked_states)
		elif control_state!=Mode:
			match Mode:
				State_carrior.control_type.FULL_LINK_CONTINUE:
					activate_states(linked_states)
				State_carrior.control_type.ISOLATED:
					deactive_states(active_states)
					active_states.clear()
	control_state = Mode
	if is_active: return
	is_active = true
	match Mode:
		State_carrior.control_type.FULL_LINK_CONTINUE:
			activate_states(linked_states if active_states.is_empty() else active_states)
		State_carrior.control_type.FULL_LINK_RESET:
			active_states.clear()
			activate_states(linked_states)
		State_carrior.control_type.ISOLATED: # This condition can be removed depending on the situation.
			active_states.clear()
	Enter()


func end_state(caller_Ref: Linked_State_Root)->void:
	if !is_active or is_always_active or caller!=caller_Ref:
		return
	caller = null
	is_active = false
	deactive_states(active_states)
	Exit()

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

func transition_to_next_states()->void:
	if is_active and is_instance_valid(caller):
		caller.process_states(self)

func process_states(sender_state:Linked_State):
	var carrier: State_carrior
	for child in active_states:
		if child.Ref==sender_state:
			carrier = child
			sender_state.end_state(self)
			activate_states(sender_state.next_states)
			active_states.erase(carrier)
			if child.can_trigger_out and is_active and !is_always_active:
				caller.transition_call(self)
			return
