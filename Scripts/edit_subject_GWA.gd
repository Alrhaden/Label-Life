extends CanvasLayer

@export var Subject_Name = "Test"
var newSubject_Name: String
@export var Subject_Grade: String
@export var Subject_Unit: String
@export var Subject_Color: Color

func _ready() -> void:
	newSubject_Name = Subject_Name
	$Panel/Sub_Ed.placeholder_text = Subject_Name
	$Panel/Color_Label.color = Subject_Color
	$Panel/Unit_Ed.placeholder_text = Subject_Unit
	$Panel/Grade_Ed.placeholder_text = Subject_Grade
	check()
	
func _on_unit_ed_text_changed(new_text: String) -> void:
	Subject_Unit = new_text
	check()
func _on_grade_ed_text_changed(new_text: String) -> void:
	Subject_Grade = new_text
	check()
func _on_sub_ed_text_changed(new_text: String) -> void:
	newSubject_Name = new_text
	print(newSubject_Name.length())
	check()

func check():
	if newSubject_Name.length() > 1:
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
	elif newSubject_Name.length() == 0:
		newSubject_Name = Subject_Name
		$Panel/Add_But.disabled = false
	else:
		$Panel/Add_But.disabled = true

func _on_add_but_pressed() -> void:
	var user = UserData.new()
	user = user.load_Resource()
	user.edit_value(Subject_Name,float(Subject_Unit),float(Subject_Grade),Subject_Color)
	user.rename_Subject(Subject_Name,newSubject_Name)
	user.save_Resource(user)
	GsSpts.refresh = false
	queue_free()
	
func _on_cancel_but_pressed() -> void:
	queue_free()
	

func _on_color_label_color_changed(color: Color) -> void:
	Subject_Color = color

func _on_delete_pressed() -> void:
	var user = UserData.new()
	user = user.load_Resource()
	user.remove_Subject(Subject_Name)
	user.save_Resource(user)
	GsSpts.refresh = false
	queue_free()
