extends Control

var path = "res://bmp display/resources/12e622536513460a.bmp" 

func load_from_file():
	pass	
	
var file = FileAccess.open(path, FileAccess.READ)
	





var bitmap_file_header = file.get_buffer(14)
var dib_header
var extra_bit_masks
var color_table
var gap1
var pixel_array
var gap2
var icc_color_profile


var bm = bitmap_file_header.decode_s8(0)



var sprite2d



#var byte = load_from_file()
#var binary = String.num_int64(byte, 2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(
		bm,"\n",
		#binary
	)
	var sprite2d = Sprite2D.new()
	add_child(sprite2d)
