extends Resource
class_name BaseDanmu

@export var vertices : PackedVector2Array
@export var color := Color.BLACK 
@export var exist_time := 3.0
@export var delay_time := 0.5
@export_group("常用子弹形状")
@export_enum("Null", "Square", "Rect", "Circle", "Pentagram") var shape : int = 0
@export var shape_argu_1 : float = 0.0
@export var shape_argu_2 : float = 0.0
@export var shape_argu_3 : float = 0.0

func display(_danmu: Area2D, _tw: Tween):
	pass
