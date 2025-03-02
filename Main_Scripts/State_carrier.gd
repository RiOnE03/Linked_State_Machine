## A Property holder resource for Linked State Machine
class_name State_carrior extends Resource 

enum control_type {
					FULL_LINK_CONTINUE, ## Starts all the linked states only the first time, afterwards the active states are only passed on to new parent State without resetting to the original linked states.
					FULL_LINK_RESET, ## Closes the active states and starts the linked states, equivalent to starting afresh.
					ISOLATED      ## Start only the selected state
					}

## This variable can only hold the values for the Linked states and is used to decided which state is in link. This property only acts as an intermediate and to actually get the state reference use the property "Ref" after setting it up.
@export_node_path("Linked_State") var state: NodePath
## This property defines the starting condition for the linked state. This section in the Linked State root only works for the initialization call.
@export var control: control_type
## Linked state exits by sending a transition call to its parent and which is responsible for stopping the linked state. This property defines whether the linked state's transition call can resest the whole parent state(Will make the parent state send a transition call to its own parent) or it should only transtion the linked state to its next states. 
@export var can_trigger_out: bool
## Holds the real reference to the state.
var Ref: Linked_State
