extends Node2D

# 获取两个 RigidBody2D 节点的引用
@onready var rigid_body_a = $RigidBody2D
@onready var rigid_body_b = $RigidBody2D2

# 声明临时变量作为类成员变量
var temspeed1 = Vector2(100, 0)
var temspeed2 = Vector2(-100, 0)

func _ready():
	# 设置初始速度
	rigid_body_a.linear_velocity = temspeed1
	rigid_body_b.linear_velocity = temspeed2
	
	# 设置物理属性
	rigid_body_a.contact_monitor = true
	rigid_body_a.max_contacts_reported = 1
	rigid_body_b.contact_monitor = true
	rigid_body_b.max_contacts_reported = 1
	
	# 连接碰撞信号
	rigid_body_a.connect("body_entered", Callable(self, "_on_body_entered"))
	rigid_body_b.connect("body_entered", Callable(self, "_on_body_entered"))

# 碰撞信号回调函数
func _on_body_entered(body):
	if body == rigid_body_a or body == rigid_body_b:
		# 反转速度
		rigid_body_a.linear_velocity = -temspeed1
		rigid_body_b.linear_velocity = -temspeed2
