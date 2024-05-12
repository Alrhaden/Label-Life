extends Control

@onready var Page_label = $Page_Label
var User = UserData.new()
var Current_Page: String
var scripting = GsSpts
var box_sub = preload("res://Pages/box_subs_GWA.tscn")
func _ready() -> void:
#Load_Data
	User = User.load_Resource()
	$Side_Nav/Nav_side/MarginContainer/VBoxContainer2/Name_p.text = User._UserName
	scripting.Subject_Add_Object(User,$Panel/MarginContainer/ScrollContainer/VBoxContainer,box_sub)
	label_refresh()
	
#Navigation Functions
func _on_nav_button_pressed() -> void:
	var tween = create_tween()
	if $Side_Nav/Nav_side.visible == true:
		tween.tween_property($Side_Nav,"position",Vector2(-454,0),.15)
		tween.tween_property($Side_Nav/Nav_side,"visible",false,.05)
		$Side_Nav/Cover.visible = false
		
	else:
		tween.tween_property($Side_Nav,"position",Vector2(0,0),.15)
		tween.tween_property($Side_Nav/Cover,"visible",true,.05)
		$Side_Nav/Nav_side.visible = true
	
func _on_cover_gui_input(event: InputEvent) -> void:
	if event is InputEvent:
		var tween = create_tween()
		tween.tween_property($Side_Nav,"position",Vector2(-454,0),.15)
		tween.tween_property($Side_Nav/Nav_side,"visible",false,.05)
		$Side_Nav/Cover.visible = false

#Floating_Nav
func _on_add_button_pressed() -> void:
	var Add = preload("res://Pages/add_subject_GWA.tscn")
	var instance = Add.instantiate()
	add_child(instance)
	

func _on_child_exiting_tree(node: Node) -> void:
	if node:
		var childrens = $Panel/MarginContainer/ScrollContainer/VBoxContainer.get_children()
		for i in childrens.size():
			$Panel/MarginContainer/ScrollContainer/VBoxContainer.remove_child(childrens[i])
		scripting.Subject_Add_Object(User,$Panel/MarginContainer/ScrollContainer/VBoxContainer,box_sub)
	label_refresh()
	
func _on_scroll_container_gui_input(event: InputEvent) -> void:
	if event and GsSpts.refresh == false:
		var childrens = $Panel/MarginContainer/ScrollContainer/VBoxContainer.get_children()
		for i in childrens.size():
			$Panel/MarginContainer/ScrollContainer/VBoxContainer.remove_child(childrens[i])
		scripting.Subject_Add_Object(User,$Panel/MarginContainer/ScrollContainer/VBoxContainer,box_sub)
		GsSpts.refresh = true
		label_refresh()

func label_refresh():
	User.load_Resource()
	User.calculate_GPA()
	$Side_Nav/Nav_side/MarginContainer/VBoxContainer2/Name_p.text = User._UserName
	if User._Subjects.size() == 0:
		$Floating_nav/Total_Subjects_L.text = "0"
		$Floating_nav/Total_Units_L.text = "0"
		$Floating_nav/Total__GWAL.text = "0"
		$Panel/Label.visible = true
	else:
		$Panel/Label.visible = false
		$Floating_nav/Total_Subjects_L.text = str(User._Subjects.size())
		$Floating_nav/Total_Units_L.text = str(User._TotalUnits)
		$Floating_nav/Total__GWAL.text = str(User._GPA)


func _on_about_pressed() -> void:
	var about = preload("res://Pages/About_Page.tscn")
	var instance = about.instantiate()
	add_child(instance)


func _on_settings_pressed() -> void:
	var settings = preload("res://Pages/settings.tscn")
	var instance = settings.instantiate()
	add_child(instance)
