extends Node2D

@export_group("弹幕列表")
@export var danmu_list : DanmuGroup

# 弹幕列表序号
var danmu_index := 0

# 子弹形状枚举
enum {
	NULL,
	SQUARE,
	RECT,
	CIRCLE,
	PENTAGRAM
}

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
	if current_danmu.shape:
		var vertices = get_vertices(current_danmu.shape, current_danmu.shape_argu_1, current_danmu.shape_argu_2, current_danmu.shape_argu_3)
		shape.polygon = vertices
		if current_danmu.shape_argu_3:
			vertices.pop_front()
			vertices.pop_front()
			collision_shape.polygon = vertices
	else:
		shape.polygon = current_danmu.vertices
		collision_shape.polygon = current_danmu.vertices
	danmu.collision_layer = 3
	danmu.collision_mask = 2
	
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

# 计算出特定子弹形状和其碰撞体形状的坐标
func get_vertices(shape: int, shape_argu_1: float, shape_argu_2: float, shape_argu_3: float):
	var points : Array[Vector2] = [Vector2(0.0, 0.0)]
	if shape == NULL:
		pass
	elif shape == SQUARE:
		points = get_square_vertices(shape_argu_1, shape_argu_3)
	elif shape == RECT:
		points = get_rect_vertices(shape_argu_1, shape_argu_2, shape_argu_3)
	elif shape == CIRCLE:
		points = get_circle_vertices(shape_argu_1, shape_argu_3)
	elif shape == PENTAGRAM:
		pass
	else:
		pass
	pass
	return points

func get_circle_vertices(radius: float, rotation_radius: float):
	var points : Array[Vector2] = []
	var points_num = 32
	var angel = 0
	var delta = 2 * PI / points_num
	if rotation_radius: # 当圆的旋转轴与圆心的距离不为零
		points.push_back(Vector2())
		points.push_back(Vector2(0.0, rotation_radius - radius))
	for i in range(0, points_num):
		var x = roundf(radius * sin(angel))
		var y = -roundf(radius * cos(angel)) + rotation_radius
		points.push_back(Vector2(x, y))
		angel += delta
	if rotation_radius:
		points.push_back(Vector2(0.0, rotation_radius - radius))
	return points

func get_square_vertices(side: float, rotation_radius: float):
	var points : Array[Vector2] = []
	var half_side = side / 2
	if rotation_radius: # 当圆的旋转轴与圆心的距离不为零
		points.push_back(Vector2())
		points.push_back(Vector2(0.0, rotation_radius - half_side))
	points.push_back(Vector2(half_side, -half_side + rotation_radius))
	points.push_back(Vector2(half_side, half_side + rotation_radius))
	points.push_back(Vector2(-half_side, half_side + rotation_radius))
	points.push_back(Vector2(-half_side, -half_side + rotation_radius))
	if rotation_radius:
		points.push_back(Vector2(0.0, rotation_radius - half_side))	
	return points
	
func get_rect_vertices(width: float, height: float, rotation_radius: float):
	var points : Array[Vector2] = []
	var half_width = width / 2
	var half_height = height / 2
	if rotation_radius: # 当圆的旋转轴与圆心的距离不为零
		points.push_back(Vector2())
		points.push_back(Vector2(0.0, rotation_radius - half_height))
	points.push_back(Vector2(half_width, -half_height + rotation_radius))
	points.push_back(Vector2(half_width, half_height + rotation_radius))
	points.push_back(Vector2(-half_width, half_height + rotation_radius))
	points.push_back(Vector2(-half_width, -half_height + rotation_radius))
	if rotation_radius:
		points.push_back(Vector2(0.0, rotation_radius - half_height))
	return points
	
