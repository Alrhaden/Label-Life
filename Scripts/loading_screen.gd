extends Control

var checkUser = UserData.new()
var GlobalScript = GsSpts

func _ready() -> void:
	var tween = create_tween()
	if checkUser.load_Resource():
		checkUser = checkUser.load_Resource()
		$Logo.visible = true
		$Logo.self_modulate = Color("ffffff00")
		tween.tween_property($Logo,"scale",Vector2(1,1),.5)
		tween.parallel()
		tween.tween_property($Logo,"position",Vector2(160,440),.5)
		tween.parallel()
		GlobalScript.Lab_tween(tween,$Logo,"self_modulate",Color("ffffff"),Color("ffffff00"),1.5,1,3.0)
		await tween.step_finished
		change()
	else:
		$Logo.visible = true
		$Logo.self_modulate = Color("ffffff00")
		$Text_Prompt.visible = true
		$Text_Prompt/Button.disabled = true
		tween.tween_property($Logo,"scale",Vector2(1,1),.5)
		tween.parallel()
		tween.tween_property($Logo,"position",Vector2(160,440),.5)
		tween.parallel()
		GlobalScript.Lab_tween(tween,$Logo,"self_modulate",Color("ffffff"),Color("ffffff00"),1.5,1,3.0)
		GlobalScript.Lab_tween(tween,$Text_Prompt,"text","Hello","",.2,.2,3.0)
		GlobalScript.Lab_tween(tween,$Text_Prompt,"text","I see that you're \n a new User","",.5,.5,3.0)
		tween.tween_property($Text_Prompt,"global_position",Vector2(67,300),1)
		tween.parallel()
		tween.tween_property($Text_Prompt,"text","What's your name?",.5)
		tween.parallel()
		tween.tween_property($Text_Prompt/LineEdit,"visible",true,.1)
		tween.tween_property($Text_Prompt/Button,"visible",true,.1)
		
func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.length() >= 3:
		$Text_Prompt/Button.disabled = false
	else:
		$Text_Prompt/Button.disabled = true


func _on_button_pressed() -> void:
	var tween = create_tween()
	checkUser._UserName = $Text_Prompt/LineEdit.text
	checkUser.save_Resource(checkUser)
	tween.tween_property($Text_Prompt,"text","",.2)
	tween.tween_property($Text_Prompt,"text","Darkmode?",.5)
	tween.parallel()
	tween.tween_property($Text_Prompt/LineEdit,"visible",false,.1)
	tween.parallel()
	tween.tween_property($Text_Prompt/Button,"visible",false,.1)
	tween.tween_property($Text_Prompt/Yes,"visible",true,.1)
	tween.parallel()
	tween.tween_property($Text_Prompt/No,"visible",true,.1)

func _on_yes_pressed() -> void:
	checkUser._Darkmode = true
	#checkUser.save_Resource(checkUser,true)
	change()
	
func _on_no_pressed() -> void:
	checkUser._Darkmode = false
	#checkUser.save_Resource(checkUser,true)
	change()

func change():
	get_tree().change_scene_to_file("res://Pages/Pages/main_page.tscn")
