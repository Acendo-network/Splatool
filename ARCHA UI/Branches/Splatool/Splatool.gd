extends Node


####################
####################
####################


### CONNECTIONS

signal inkspam_results_raw(selected_sub_weapon, ism_iruk_result, ism_irus_result, iss_iruk_result, iss_irus_result)
signal inkspam_results_rich_text(text)

@onready var root_node = get_node("../..")

@onready var subweapon_nodes_array = [
	get_node("SubWeapons/AngleShooter"),
	get_node("SubWeapons/Autobomb"),
	get_node("SubWeapons/Burst"),
	get_node("SubWeapons/Curling"),
	get_node("SubWeapons/Fizzy"),
	get_node("SubWeapons/InkMine"),
	get_node("SubWeapons/PointSensor"),
	get_node("SubWeapons/SplashWall"),
	get_node("SubWeapons/SplatBomb"),
	get_node("SubWeapons/Sprinkler"),
	get_node("SubWeapons/SquidBeakon"),
	get_node("SubWeapons/SuctionBomb"),
	get_node("SubWeapons/Torpedo"),
	get_node("SubWeapons/ToxicMist"),
	]


####################
####################
####################


### OPERATIONS
	
func parabola_curve_equation(x,a,b,c):
	var y = a*x**2 - b*x + c
	return y
	
	
	
func multiply_opposed_curves(curve1, curve2):
	# Exceptions
	if curve1.size() != curve2.size():
		push_error("The two provided Arrays do not have matching item counts")
	# Data
	var final_points_array : Array
	var curve_resolution = curve1.size()
	# Operations
	for i in curve_resolution:
		final_points_array.append(curve1[i] * curve2[-1+curve_resolution-i])
	# Connect
	return final_points_array
	
	
	
func fps60_frames_to_sec(x):
	return x/60
	
	
	
func scale_curve(curve : Array, scaler_function : Callable):
	# Data
	var scaled_curve : Array
	# Operations
	for i in curve.size():
		scaled_curve.append(scaler_function.call(curve[i]))
	# Connect
	return scaled_curve
	
	
	
func weigh_curve(curve : Array, weight_factor : float):
	# Data
	var scaled_curve : Array
	# Operations
	for i in curve.size():
		scaled_curve.append(curve[i]*weight_factor)
	# Connect
	return scaled_curve
	
	
	
func lowest_curve_points(curve_array, result_decimal_precision):
		
	var result_template = {"value": 100, "index": [0]}
	var curve_resolution = curve_array.size()
		
	for i in curve_resolution:
		var rouded_curve_point = snapped(curve_array[i], 1.0 / (10 ** result_decimal_precision))
		if rouded_curve_point < result_template["value"]:
			result_template["value"] = rouded_curve_point
			result_template["index"][0] = i
		elif rouded_curve_point == result_template["value"]:
			result_template["index"].append(i)
		else:
			break
		
	return result_template



func percent_to_unit_ratio(x):
	return x/100.0


####################
####################
####################


### DATA

## You'll need to fix up the exact values, cuz it doesn't give exact values.
#var parama = [0.000054235,0.0000813524,0.0000948956,0.00010845,0.0000783197,0.000121996,0.103014,0.0167883]
#var paramb = [0.00661038,0.00991591,0.0115677,0.0132204,0.00954775,0.01485,12.53846,2.0622]
#var paramc = [1,1,1,1,1,1,600,180]

var splatoon_curve_parameters = {
	"ink_saver_sub_type_0" :		{"a":0.000054235,	"b":0.00661038,	"c":1},
	"ink_saver_sub_type_1" :		{"a":0.0000813524,	"b":0.00991591,	"c":1},
	"ink_saver_sub_type_2" :		{"a":0.0000948956,	"b":0.0115677,	"c":1},
	"ink_saver_sub_type_3" :		{"a":0.00010845,	"b":0.0132204,	"c":1},
	"ink_saver_sub_type_4" :		{"a":0.0000783197,	"b":0.00954775,	"c":1},
	"ink_saver_main" :				{"a":0.000121996,	"b":0.01485,	"c":1},
	"ink_recovery_up_kid_form" :	{"a":0.103014,		"b":12.53846,	"c":600},
	"ink_recovery_up_squid_form" :	{"a":0.0167883,		"b":2.0622,		"c":180},
}

var splatoon_ability_points_max_value : int = 57
var splatoon_ability_points_possible_values : int = 1 + 57 


####################
####################
####################


### PROGRAM

func _ready() -> void:
	root_node.parameters.connect(recompute_output)
	#print(1.0/(10**3))
	
func recompute_output(sub_weapon_index, decimal_precision) -> void:
	# Data
	var selected_sub_weapon = subweapon_nodes_array[sub_weapon_index]
	
	var iss_curve_names = ["ink_saver_sub_type_0", "ink_saver_sub_type_1", "ink_saver_sub_type_2", "ink_saver_sub_type_3", "ink_saver_sub_type_4"]
	var type = iss_curve_names[selected_sub_weapon.curvetype]

	# Less verbose
	var param = splatoon_curve_parameters # Less verbose
	var ism = "ink_saver_main" # Less verbose
	var iruk = "ink_recovery_up_kid_form" # Less verbose
	var irus = "ink_recovery_up_squid_form" # Less verbose
	# Less verbose
	
	# Still data
	var iss_curve : Array
	var ism_curve : Array
	var iruk_curve : Array
	var irus_curve : Array
	
	# Operations
	for i in splatoon_ability_points_possible_values:
		iss_curve.append(	parabola_curve_equation(	i,	param[type]["a"],	param[type]["b"],	param[type]["c"]	))
		ism_curve.append(	parabola_curve_equation(	i,	param[ism]["a"],	param[ism]["b"],	param[ism]["c"]		))
		iruk_curve.append(	parabola_curve_equation(	i,	param[iruk]["a"],	param[iruk]["b"],	param[iruk]["c"]	))
		irus_curve.append(	parabola_curve_equation(	i,	param[irus]["a"],	param[irus]["b"],	param[irus]["c"]	))
	
	var main_inktank_cost_ratio = 1.0 # placeholder until accurate shot consumption
	var sub_inktank_cost_ratio = percent_to_unit_ratio(selected_sub_weapon.inkcost)
	
	var ism_curve_weighed_to_inkcost = weigh_curve(ism_curve, main_inktank_cost_ratio)
	var iss_curve_weighed_to_inkcost = weigh_curve(iss_curve, sub_inktank_cost_ratio)
	
	var ism_iruk_result = lowest_curve_points(	scale_curve(	multiply_opposed_curves(ism_curve_weighed_to_inkcost, iruk_curve), fps60_frames_to_sec		), decimal_precision	)
	var ism_irus_result = lowest_curve_points(	scale_curve(	multiply_opposed_curves(ism_curve_weighed_to_inkcost, irus_curve), fps60_frames_to_sec		), decimal_precision	)
	var iss_iruk_result = lowest_curve_points(	scale_curve(	multiply_opposed_curves(iss_curve_weighed_to_inkcost, iruk_curve), fps60_frames_to_sec		), decimal_precision	)
	var iss_irus_result = lowest_curve_points(	scale_curve(	multiply_opposed_curves(iss_curve_weighed_to_inkcost, irus_curve), fps60_frames_to_sec		), decimal_precision	)
	
	inkspam_results_raw.emit(selected_sub_weapon, ism_iruk_result, ism_irus_result, iss_iruk_result, iss_irus_result)
	
	var rich_text_result = InkspamRichTextConverter.convert(selected_sub_weapon, ism_iruk_result, ism_irus_result, iss_iruk_result, iss_irus_result)
	
	inkspam_results_rich_text.emit(rich_text_result)
	
	
	
