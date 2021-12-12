tool
class_name CameraAttractor
extends Node2D

export (float, 0, 10000) var outer_radius = 100 setget set_outer_radius
export (float, 0, 10000) var inner_radius = 50 setget set_inner_radius
export (bool) var debug = false setget set_debug

func set_outer_radius(value: float) -> void:
	outer_radius = value
	inner_radius = min(inner_radius, value)
	update()

func set_inner_radius(value: float) -> void:
	inner_radius = min(outer_radius, value)
	update()

func set_debug(value: bool) -> void:
	debug = value
	update()

func _draw() -> void:
	if Engine.is_editor_hint() or debug:
		draw_arc(Vector2.ZERO, inner_radius, 0, PI * 2, 32, Color.aqua)
		draw_arc(Vector2.ZERO, outer_radius, 0, PI * 2, 32, Color.cornflower)


func _ready() -> void:
	if Engine.is_editor_hint():
		return

	# Create area 2d for collisions with camera
	var shape = CircleShape2D.new()
	shape.radius = outer_radius
	var collision = CollisionShape2D.new()
	collision.shape = shape
	var area = Area2D.new()
	# Collisions are monitored from outside of this trigger
	area.monitoring = false
	area.add_child(collision)
	add_child(area)

