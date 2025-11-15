extends CanvasLayer

@onready var map_illustration: TextureRect = $map_illustration
@onready var map: CanvasLayer = $"."

var map_visible = false

var map_dictionary = {
	"res://scenes/levels/dusty_bottom.tscn": "res://assets/maps/dusty_bottom.png",
	"res://scenes/levels/tutorial.tscn": "res://assets/maps/tutorial.png"
}

func show_map():
	print(map_dictionary[SaveLoad.SaveFileData.current_scene])
	map_illustration.texture = load(map_dictionary[SaveLoad.SaveFileData.current_scene])
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SceneLoader.scene_changed.is_connected(Callable(self, "show_map")):
		SceneLoader.scene_changed.connect(Callable(self, "show_map"))
		show_map()
	map.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("show_map"):
		print("show map")
		map.visible = !map.visible
		map_visible = map.visible
		
	pass
