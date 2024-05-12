extends Panel

@export var Sub_Name: String
@export var Sub_Grade: String
@export var Sub_Unit: String
@onready var Sub_Color: Color

func _ready() -> void:
	$Unit/Unit_Label.text = Sub_Unit
	$Subject/Subject_Label.text = Sub_Name
	$Grade/Grade_Label.text = Sub_Grade
	$Color_Sub.color = Sub_Color
	
func _on_edit_pressed() -> void:
	var Edit = preload("res://Pages/edit_subject_GWA.tscn")
	var instance = Edit.instantiate()
	instance.Subject_Name = Sub_Name
	instance.Subject_Grade = Sub_Grade
	instance.Subject_Unit = Sub_Unit
	instance.Subject_Color = Sub_Color
	add_child(instance)
