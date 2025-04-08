extends Node

### CONNECT

signal parameters_changed
signal parameters(sub_weapon_index, decimal_precision) #generalize with Kwargs ?
signal output_text(sent_text)

@onready var splatool = get_node("Imported modules/Splatool")
@onready var archa_text_field = get_node("UI Root/VBox/Main section/Content panel/Scroll/Margin/ARCHA print")
@onready var auto_refresh_toggle = get_node("UI Root/VBox/Main section/Side panel/Scroll/Margin/VBox/Auto refresh toggle")
@onready var sub_weapon_drop_down = get_node("UI Root/VBox/Main section/Side panel/Scroll/Margin/VBox/Sub weapon drop down")
@onready var decimal_precision_slider = get_node("UI Root/VBox/Main section/Side panel/Scroll/Margin/VBox/Decimal precision/Slider")
@onready var decimal_precision_label = get_node("UI Root/VBox/Main section/Side panel/Scroll/Margin/VBox/Decimal precision/Text")

@onready var auto_refresh : bool = auto_refresh_toggle.button_pressed
@onready var sub_weapon_index = sub_weapon_drop_down.selected
@onready var decimal_precision = decimal_precision_slider.value
@onready var stored_results = "placeholder value"

# const ANGLE_SHOOTER = preload("res://ARCHA UI/Branches/Splatool/resources/Splatoon icons/Angle Shooter.png")

### DATA





### OPERATIONS

func resize_dropdown_icons():
	for i in sub_weapon_drop_down.item_count:
		var extracted_image = sub_weapon_drop_down.get_item_icon(i).get_image()
		extracted_image.resize(48, 48, 2)
		var repacked_image = ImageTexture.create_from_image(extracted_image)
		sub_weapon_drop_down.set_item_icon(i, repacked_image)

func update_label_text():
	decimal_precision_label.text = "Decimal precision : " + str(decimal_precision)



func _ready() -> void:
	resize_dropdown_icons()
	update_label_text()
	parameters_changed.connect(check_auto_refresh)
	splatool.inkspam_results_rich_text.connect(display_text)



func _on_refresh_button_pressed() -> void:
	send_parameters_for_compute()

func _on_auto_reload_toggle_toggled(toggle_state: bool) -> void:
	auto_refresh = toggle_state

func _on_sub_selector_item_selected(index: int) -> void:
	sub_weapon_index = index
	parameters_changed.emit()

func _on_decimal_precision_value_changed(value: float) -> void:
	decimal_precision = value
	update_label_text()
	parameters_changed.emit()



func send_parameters_for_compute():
	parameters.emit(sub_weapon_index, decimal_precision)

func check_auto_refresh():
	match auto_refresh:
		true: send_parameters_for_compute()
		false: return

func store_results(text):
	stored_results = text

func display_text(text):
	output_text.emit(text)




























	
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
