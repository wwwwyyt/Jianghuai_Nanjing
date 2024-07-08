extends Node2D

@export_group("弹幕列表")
@export var danmu_list : DanmuGroup

var danmu_index := 0

func display_next_danmu():
	# 创建一个新子弹
	var danmu := Area2D.new()
	var shape := Polygon2D.new()
	var collision_shape := CollisionPolygon2D.new()
	
	# 当子弹列表中的子弹展示完毕，退出
	if danmu_index >= len(danmu_list.danmu_list):
		return
	
	# 设置新子弹的信息
	var current_danmu := danmu_list.danmu_list[danmu_index]
	shape.color = current_danmu.color
	shape.polygon = current_danmu.vertices
	collision_shape.polygon = current_danmu.vertices
	
	# 设置下一次“发射”子弹的间隔
	var delay_timer := get_tree().create_timer(current_danmu.delay_time)
	delay_timer.connect("timeout", _on_delay_timer_time_out)
	
	# 将新子弹加入场景树
	danmu.add_child(shape)
	danmu.add_child(collision_shape)
	add_child(danmu)
	
	# 播放新子弹的动画
	var tw := get_tree().create_tween()
	current_danmu.display(danmu, tw)
	
	danmu_index += 1

func _ready():
	display_next_danmu()

func _on_delay_timer_time_out():
	display_next_danmu()
