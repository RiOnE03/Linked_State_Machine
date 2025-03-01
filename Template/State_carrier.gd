## A Property holder resource for Linked State Machine
class_name State_carrior extends Resource 

enum control_type {
					FULL_CONTROL, ## Start all the linked states
					ISOLATED      ## Start only the current state
					}

## This variable can only hold the values for the Linked states and is used to decided which state is in link. This property only acts as an intermediate and to actually get the state reference use the property "Ref".
@export_node_path("Linked_State") var state: NodePath
## This property defines if this state should also start all its linked states or only start itself. This section in the Linked State root only works for the initialization call.
@export var control: control_type
## This property defines if this state is initiated, should it starts as a fresh new state or continue from where it left. This property has no effect in the Linked State Root node.
@export var start_fresh: bool
## Linked state stops by sending a transition call to its parent and stoping itself and its linked state. This property defines whether the child transition call can resest the whole parent state(All currently running linked states will stop and the parent state will also stop) or it should only transtion the child state to its next states. 
@export var can_trigger_out: bool
## Holds the real reference to the state.
var Ref: Linked_State
