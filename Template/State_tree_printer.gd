@tool
class_name Linked_Tree_Printer extends Node 

@export var root_nodes: Array[Linked_State_Root]
## If this field is not filled then the output will be printed on the Output Console. However since the output console can't be cleared. It'll get cluttered
@export var printing_medium: RichTextLabel
@export var print_periodically: bool:
	set(value):
		print_periodically = value
		notify_property_list_changed()
@export_range(0.1, 10) var print_delay: float = 0.2

func _validate_property(property: Dictionary) -> void:
	if property.name == "print_delay" and not print_periodically:
		property.usage = PROPERTY_USAGE_READ_ONLY

var current_time: float
func _ready() -> void:
	pass

func repeat(count: int, character: String)->String:
	var returner: String = ""
	for c in count:
		returner += character
	return returner

func recursive_addition(node: Linked_State_Root,text: String = "", prev_letter_count: int = 0,order: int = 0)->String:
	text=  repeat(prev_letter_count*2,' ') + "|" +repeat(order,'-')+ ">" + node.name + '\n'
	order+=1
	prev_letter_count += node.name.length() + 3
	var list: Array[State_carrior] 
	if node is Linked_State:
		list = node.active_states
	elif node is Linked_State_Root:
		list = node.linked_states
	for child in list:
		if is_instance_valid(child.Ref):
			text += recursive_addition(child.Ref,text, prev_letter_count,order)
	return text

func update_manually()->void:
	if is_instance_valid(printing_medium):
		printing_medium.text = ""
	for root in root_nodes:
		if is_instance_valid(printing_medium):
			printing_medium.text += recursive_addition(root) + '\n'
		else:
			print(recursive_addition(root))

func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint() and print_periodically:
		current_time+=delta
		if current_time>=print_delay:
			current_time = 0
			update_manually()
