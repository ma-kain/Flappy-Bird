extends CenterContainer

const current_score_key = "current_score"
const best_score_key = "best_score"
const last_best_score_key = "last_best_score"
const medal_key = "medal"

const medal_bronze = preload("res://sprites/medal_bronze.png")
const medal_gold = preload("res://sprites/medal_gold.png")
const medal_platinum = preload("res://sprites/medal_platinum.png")
const medal_silver = preload("res://sprites/medal_silver.png")

var medals = {
	"bronze": medal_bronze,
	"gold": medal_gold,
	"platinum": medal_platinum,
	"silver": medal_silver,
}

func _ready():
	pass

func animate_gameover_panel():
	$animation_player.play("gameover")
	yield($animation_player, "animation_finished")

	var duration = .5
	yield(_animate_current_score(duration), "completed")
	
	yield(_animate_best_score(duration), "completed")
	
	_show_medal()
	
	$animation_player.play("lower_panel")
	yield($animation_player, "animation_finished")

func _show_medal():
	var key = data_store.get(medal_key)
	if medals.has(key):
		$v_container/score_texture/medal_texture.texture = medals[key]
		$v_container/score_texture/medal_texture.show()
		$v_container/score_texture/animation_player.play("shining")

func _animate_current_score(duration):
	var current_score = data_store.get(current_score_key)

	yield(_animate_as_counting_score(0, current_score, 
		$v_container/score_texture/current_score, duration),
		"completed")

func _animate_best_score(duration):
	var last_best_score = data_store.get(last_best_score_key)
	var new_best_score = data_store.get(best_score_key)

	yield(_animate_as_counting_score(last_best_score, new_best_score, 
		$v_container/score_texture/best_score, duration),
		"completed")
	
	_show_new_tag_texture()

func _show_new_tag_texture():
	var last_best_score = data_store.get(last_best_score_key)
	var new_best_score = data_store.get(best_score_key)

	if new_best_score > last_best_score:
		$v_container/score_texture/new_texture.show()

func _animate_as_counting_score(from: int, to: int, label: Label, 
	duration: float):
	var time_lapsed: float = 0
	while time_lapsed < duration:
		time_lapsed += get_process_delta_time()
		var bounded_time_lapsed = min(time_lapsed, duration)
		var lerper = bounded_time_lapsed / duration
		var lerped_number = lerp(from, to, lerper)	
		label.text = str(int(lerped_number))
		yield(get_tree(), "idle_frame")

