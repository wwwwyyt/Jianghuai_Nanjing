extends BaseDanmu
class_name LinearDanmu

@export var start_point : Vector2
@export var end_point : Vector2 
@export var speed : int

func display(danmu: Area2D, tw: Tween):
	var distance = (end_point - start_point).length()
	var time = distance / speed
	
	tw.bind_node(danmu)
	tw.set_parallel()
	tw.tween_property(danmu, "position", end_point, time).from(start_point)
	tw.tween_callback(danmu.queue_free).set_delay(exist_time)
