extends Node
var refresh = false

func Lab_tween(tween: Tween,tweenObj: Object,propertyEntrance: String,EntranceValue,finalValue, timeEntrance: float, timeFinal: float,waitDuration: float):
	tween.tween_property(tweenObj,propertyEntrance,EntranceValue,timeEntrance)
	tween.tween_property(tweenObj,propertyEntrance,EntranceValue,waitDuration)
	tween.tween_property(tweenObj,propertyEntrance,finalValue,timeFinal)

func Subject_Add_Object(User_Data: UserData,VboxSubs: VBoxContainer,Boxnode):	
	if User_Data._Subjects.size() > 0:
		var Subjects = User_Data._Subjects.keys()
		var UnGrade = User_Data._Subjects.values()
		for i in Subjects.size():
			var instance = Boxnode.instantiate()
			instance.Sub_Name = Subjects[i]
			instance.Sub_Grade = str(UnGrade[i][1])
			instance.Sub_Unit = str(UnGrade[i][0])
			instance.Sub_Color = UnGrade[i][2]
			VboxSubs.add_child(instance)
