extends Node

class_name InkspamRichTextConverter

signal rich_text_results(text)

@onready var splatool = get_node("Imported modules/Splatool")



func _ready() -> void:
	splatool.inkspam_results.connect()

static func convert(selected_sub_weapon, ism_iruk_result, ism_irus_result, iss_iruk_result, iss_irus_result):
	var result_text = (
		"[b]Sub weapon selected = " + selected_sub_weapon.wepname + "[/b]" +
		"\n\n" +
		"[table=3][cell]Type		[/cell][cell][hint=Lowest amount of time (in seconds) possible between shots, if you use the correct ability points]Lowest time (in seconds)[/hint]	[/cell][cell][hint=How many ability points you need to have of 'Ink Saver Main' or 'Ink Saver Sub', with the rest of the ability points filled with 'Ink Recovery Up'.]ISM or ISS Ability points required[/hint]" +
		"[/cell][cell border=#ffffff00][hint=Lowest amount of time (in seconds) possible between shots of the main weapon while in kid form, if you use the correct ability points]Main weapon / Kid form[/hint][/cell][cell border=#ffffff00]" + str(ism_iruk_result["value"]) + "[/cell][cell border=#ffffff00]" + str(ism_iruk_result["index"]) + 
		"[/cell][cell border=#ffffff00][hint=Lowest amount of time (in seconds) possible between shots of the main weapon while in squid form, if you use the correct ability points]Main weapon / Squid form[/hint][/cell][cell border=#ffffff00]" + str(ism_irus_result["value"]) + "[/cell][cell border=#ffffff00]" + str(ism_irus_result["index"]) +
		"[/cell][cell border=#ffffff00][hint=Lowest amount of time (in seconds) possible between shots of the sub weapon while in kid form, if you use the correct ability points]Sub weapon / Kid form[/hint][/cell][cell border=#ffffff00]" + str(iss_iruk_result["value"]) + "[/cell][cell border=#ffffff00]" + str(iss_iruk_result["index"]) +
		"[/cell][cell border=#ffffff00][hint=Lowest amount of time (in seconds) possible between shots of the sub weapon while in squid form, if you use the correct ability points]Sub weapon / Squid form[/hint][/cell][cell border=#ffffff00]" + str(iss_irus_result["value"]) + "[/cell][cell border=#ffffff00]" + str(iss_irus_result["index"]) + "[/cell][/table]" + 
		"\n\n"
		)
	
	return result_text
