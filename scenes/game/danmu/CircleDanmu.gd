extends BaseDanmu
class_name CircleDanmu

@export var centre : Vector2
@export var start_rotation := 0.0
@export var angular_velocity : float

func display(danmu: Area2D, tw: Tween):
	danmu.position = centre
	danmu.rotation_degrees = start_rotation
	var delta_angel = angular_velocity * exist_time
	
	tw.bind_node(danmu)
	tw.set_parallel()
	tw.tween_property(danmu, "rotation", delta_angel, exist_time).as_relative()
	tw.tween_callback(danmu.queue_free).set_delay(exist_time)
