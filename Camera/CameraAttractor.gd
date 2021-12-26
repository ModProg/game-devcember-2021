tool
class_name CameraAttractor
extends Node2D

export (float, 0, 10000) var outer_radius = 100 setget set_outer_radius
export (float, 0, 10000) var inner_radius = 50 setget set_inner_radius
export (float, 0, 10) var zoom = 1 setget set_zoom
export (bool) var show_camera_frame = true setget set_show_camera_frame
export (bool) var debug = false setget set_debug

var viewport_width: int
var viewport_height: int

func set_outer_radius(value: float) -> void:
	outer_radius = value
	inner_radius = min(inner_radius, value)
	update()

func set_inner_radius(value: float) -> void:
	inner_radius = min(outer_radius, value)
	update()
	
func set_zoom(value: float) -> void:
	zoom = value
	update()

func set_show_camera_frame(value: bool) -> void:
	show_camera_frame = value
	update()

func set_debug(value: bool) -> void:
	debug = value
	update()
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED and global_scale != Vector2.ONE:
		global_scale = Vector2.ONE

func _draw() -> void:
	if Engine.is_editor_hint() or debug:
		draw_arc(Vector2.ZERO, inner_radius, 0, PI * 2, 32, Color.aqua)
		draw_arc(Vector2.ZERO, outer_radius, 0, PI * 2, 32, Color.cornflower)
		if show_camera_frame:
			var half_width = floor(viewport_width / 2)
			var half_height = floor(viewport_height / 2)
			draw_rect(
				Rect2(
					Vector2(-half_width, -half_height) * zoom,
					Vector2(viewport_width, viewport_height) * zoom
				),
				Color.darkgoldenrod,
				false,
				2
			)


func _ready() -> void:
	set_notify_transform(true)
	viewport_width = ProjectSettings.get_setting('display/window/size/width')
	viewport_height = ProjectSettings.get_setting('display/window/size/height')
	
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

