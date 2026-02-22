extends Node2D

signal completed
signal progress_changed(p_progress: float)


var particle_systems = [
	"uid://1uvl8pn3bk6v"
]
var canvas_items = [
	"uid://ccwgiu4snij5f"
]

var total_work_needed: int = 0
var total_particle_systems_processed: int = 0
var total_canvas_items_processed: int = 0

@onready var color_rect: ColorRect = $ColorRect
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	total_work_needed = particle_systems.size() + canvas_items.size()

func _get_total_work_done() -> int:
	return total_particle_systems_processed + total_canvas_items_processed

func _process(_delta: float) -> void:
	if total_work_needed == 0:
		queue_free()
		return
	
	if not particle_systems.is_empty():
		gpu_particles_2d.process_material = load(particle_systems.pop_front())
		total_work_needed -= 1
	
	if not canvas_items.is_empty():
		color_rect.material = load(canvas_items.pop_front())
		total_work_needed -= 1
