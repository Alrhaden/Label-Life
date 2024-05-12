extends CanvasLayer

var Subject_Name: String
var Subject_Grade: String
var Subject_Unit: String
@onready var Subject_Color = $Panel/Color_Label.color

func _on_unit_ed_text_changed(new_text: String) -> void:
	Subject_Unit = new_text
	check()
func _on_grade_ed_text_changed(new_text: String) -> void:
	Subject_Grade = new_text
	check()
func _on_sub_ed_text_changed(new_text: String) -> void:
	Subject_Name = new_text
	check()

func check():
	if Subject_Name.length() >= 2:
		$Panel/Unit_Ed.editable = true
		if Subject_Unit.is_valid_float():
			$Panel/Grade_Ed.editable = true
			if Subject_Grade.is_valid_float():
				$Panel/Add_But.disabled = false
			else:
				$Panel/Add_But.disabled = true
		else:
			$Panel/Add_But.disabled = true
			$Panel/Grade_Ed.editable = false
	else:
		$Panel/Add_But.disabled = true

func _on_add_but_pressed() -> void:
	var user = UserData.new()
	user = user.load_Resource()
	user.add_Subject(Subject_Name,float(Subject_Unit),float(Subject_Grade),Subject_Color)
	user.save_Resource(user)
	queue_free()

func _on_cancel_but_pressed() -> void:
	queue_free()


func _on_color_label_color_changed(color: Color) -> void:
	Subject_Color = color
