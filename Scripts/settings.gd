extends CanvasLayer

var user = UserData.new()
var my_name: String

func _ready() -> void:
	user = user.load_Resource()
	$Panel/Label2/LineEdit.placeholder_text = user._UserName
	$CheckBox.disabled = user._Darkmode


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.length() >= 3:
		my_name = new_text
		$Panel/Add_But.disabled = false
	else:
		$Panel/Add_But.disabled = true

func _on_check_box_toggled(toggled_on: bool) -> void:
	user._Darkmode = toggled_on

func _on_cancel_but_pressed() -> void:
	queue_free()

func _on_add_but_pressed() -> void:
	user._UserName = my_name
	user.load_Resource()
	user.save_Resource(user)
	queue_free()
