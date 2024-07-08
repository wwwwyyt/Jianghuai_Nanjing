extends BaseDanmu
class_name LinearDanmu

@export var start_point : Vector2
@export var end_point : Vector2 
@export var speed : int

func display(danmu: Area2D, tw: Tween):
	var distance = (end_point - start_point).length()
	var time = distance / speed
	
	danmu.position = start_point
	tw.tween_property(danmu, "position", end_point, time)
	tw.tween_callback(danmu.queue_free).set_delay(exist_time)
