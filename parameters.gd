extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

onready var posx = $posxedit
var posxt
onready var posy = $posyedit
var posyt
onready var posz = $poszedit
var poszt
onready var velx = $velxedit
var velxt
onready var vely = $velyedit
var velyt
onready var velz = $velzedit
var velzt
onready var velmag = $speededit
var velmagt

func _on_posxedit_text_changed():
	posxt = posx.text
	Globalvar.posxt = float(posxt)
	print("Starting X coordinate changed to:" + str(posxt))
	#add exceptions for inconvertible entries

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print(posxt)

func _on_velzedit_text_changed():
	velzt = velz.text
	Globalvar.velzt = float(velzt)
	print("Starting Z component of velocity changed to:" + str(velzt))

func _on_velyedit_text_changed():
	velyt = vely.text
	Globalvar.velyt = float(velyt)
	print("Starting Y component of velocity changed to:" + str(velyt))

func _on_velxedit_text_changed():
	velxt = velx.text
	Globalvar.velxt = float(velxt)
	print("Starting X component of velocity changed to:" + str(velxt))

func _on_speededit_text_changed():
	velmagt = velmag.text
	Globalvar.velmagt = float(velmagt)
	print("Starting speed changed to:" + str(velmagt))

func _on_poszedit_text_changed():
	poszt = posz.text
	Globalvar.poszt = float(poszt)
	print("Starting Z coordinate changed to:" + str(poszt))

func _on_posyedit_text_changed():
	posyt = posy.text
	Globalvar.posyt = float(posyt)
	print("Starting Y coordinate changed to:" + str(posyt))

func _on_Button_pressed():
	get_tree().change_scene("res://System.tscn")
	
func _ready():
#	System.shuttle.global_translation = Vector3(float(posxt),float(poszt),float(posyt))
#	System.shuttle.linear_velocity = float(velmagt)*Vector3(float(velxt),float(velzt),float(velyt))
	pass
