extends Resource

class_name UserData

#User Settings
@export var _UserName: String = ""
@export var _Darkmode: bool
@export var _isFirstTime = true
var currentPage = ""

#User Subjects GPW
@export var _Subjects: Dictionary = {}
var _HighScore: int
var _TotalWeightedGrade: float
var _TotalUnits: float
var _GWA: float
var _GPA: float
#User Dates

 
#Subject Manipulation
func add_Subject(Subject: String, Unit: float, Grade: float, color: Color):
	var UnGrade = [Unit,Grade,color]
	var add = {Subject : UnGrade}
	if _Subjects.has(Subject):
		return
	else:
		_Subjects.merge(add)
	calculate_GPA()

func remove_Subject(Subject: String):
	_Subjects.erase(Subject)
	calculate_GPA()

func edit_value(Subject: String, Unit: float, Grade: float,color: Color):
	var UnGrade = [Unit,Grade,color]
	var edit = {Subject: UnGrade}
	if _Subjects.has(Subject):
		_Subjects.merge(edit,true)
	else:
		return
	calculate_GPA()
	
func rename_Subject(Subject: String, Rename: String):
	var rename = {Rename : _Subjects.get(Subject)}
	if _Subjects.has(Subject):
		_Subjects.erase(Subject)
		_Subjects.merge(rename,true)
	else:
		return

#Calculation
func calculate_GPA():
	if _Subjects.size() <= 0:
		_GPA = 0
		_TotalUnits = 0
		_TotalWeightedGrade = 0
	else:
		_TotalUnits = 0
		_TotalWeightedGrade = 0
		var Subject_UnGrade = _Subjects.values()
		for i in Subject_UnGrade.size():
			for u in Subject_UnGrade[i].size() - 2:
				_TotalWeightedGrade += Subject_UnGrade[i][u] * Subject_UnGrade[i][u+1]
				_TotalUnits += Subject_UnGrade[i][u]
		_GPA = snappedf(_TotalWeightedGrade / _TotalUnits,0.0001)
		
#Resource Saver
func save_Resource(Userdata: Resource):
	ResourceSaver.save(Userdata,"user://Le.tres")

#Resource Loader
func load_Resource():
	if ResourceLoader.exists("user://Le.tres"):
		return ResourceLoader.load("user://Le.tres")
	return false

