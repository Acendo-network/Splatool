extends RichTextLabel

# onready to make it accessible to all functions in this script, vs. only local to ready function.
@onready var root_node = get_node("../../../../../../..")

func _ready() -> void:
	root_node.output_text.connect(refresh_text_field)


func refresh_text_field(passed_text):
	print_rich(passed_text)
	text = passed_text
