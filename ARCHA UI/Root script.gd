extends Node

### CONNECT

signal send_selected_inputs(sub_weapon_index, decimal_precision)
signal new_inputs_selected
signal send_archa_print(passed_message)

@onready var splat_calc_module = get_node("Imported modules/SplatCalc")
@onready var archa_print_field = get_node("VBoxContainer/HSplitContainer/Container/ScrollContainer/MarginContainer/ARCHA print")
@onready var sub_selector: OptionButton = $"VBoxContainer/HSplitContainer/Side panel/ScrollContainer/Margin/VBoxContainer/Sub selector" # Cheapo quick edit, too lazy
@onready var decimal_precision_slider = get_node("VBoxContainer/HSplitContainer/Side panel/ScrollContainer/Margin/VBoxContainer/HBoxContainer/Decimal precision")
@onready var decimal_slider_text: RichTextLabel = $"VBoxContainer/HSplitContainer/Side panel/ScrollContainer/Margin/VBoxContainer/HBoxContainer/RichTextLabel"  # Cheapo quick edit, too lazy



### DATA

@onready var sub_weapon_index = sub_selector.selected
@onready var decimal_precision = decimal_precision_slider.value



### OPERATIONS

func update_displayed_values():
	decimal_slider_text.text = "Decimal precision : " + str(decimal_precision)


func _ready() -> void:
	update_displayed_values()
	splat_calc_module.splatcalc_result_print.connect(send_message_to_archa_print)
	new_inputs_selected.connect(send_inputs_to_splatcalc)


func _on_sub_selector_item_selected(index: int) -> void:
	sub_weapon_index = index
	new_inputs_selected.emit()

func _on_decimal_precision_value_changed(value: float) -> void:
	decimal_precision = value
	update_displayed_values()
	new_inputs_selected.emit()


func send_inputs_to_splatcalc():
	send_selected_inputs.emit(sub_weapon_index, decimal_precision)

func send_message_to_archa_print(result_text: Variant) -> void:
	send_archa_print.emit(result_text)























	
	#print_rich("[table=3]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the main weapon while in kid form]Main kid[/hint][/cell][cell]" + str(ismirukresult["lowest time"]) + "[/cell][cell]" + str(ismirukresult["required AP"]) + "[/cell]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the main weapon while in squid form]Main squid[/hint][/cell][cell]" + str(ismirusresult["lowest time"]) + "[/cell][cell]" + str(ismirusresult["required AP"]) + "[/cell]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the sub weapon while in kid form]Sub kid[/hint][/cell][cell]" + str(issirukresult["lowest time"]) + "[/cell][cell]" + str(issirukresult["required AP"]) + "[/cell]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the sub weapon while in squid form]Sub squid[/hint][/cell][cell]" + str(issirusresult["lowest time"]) + "[/cell][cell]" + str(issirusresult["required AP"]) + "[/cell]")
	#print_rich("[/table]")
	
		
#	for n in 58:
#		if ismirukpoints[n] <= ismirukresult["lowest time"]:
#			ismirukresult["lowest time"] = ismirukpoints[n] 
#			ismirukresult["required AP"].append(n)
		




#func _input(event):
#	if event.is_action_pressed("Print"):
#		print("""
#		""")
#		print(curves(57,wepselect.curvetype))
#		print(wepselect.curvetype)
