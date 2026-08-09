extends Control


var stage_idx = 0:
	set(value):
		$Control.get_child(stage_idx).hide()
		
		stage_idx = value
		if stage_idx < 3:
			$Control.get_child(stage_idx).show()
			

var current_points_total = 0


func _ready() -> void:
	for i in $Control.get_children():
		i.stage_finished.connect(_on_stage_finished)


func _physics_process(delta: float) -> void:
	$CanvasLayer/Points.text = 'Points: %d' % current_points_total


func _on_stage_finished(points) -> void:
	current_points_total += points
	stage_idx += 1


func _on_osint_search_stage_finished(points) -> void:
	$Control/OsintSearch.hide()
	$CanvasLayer/FinalQuestionPanel.show()


func _on_final_question_panel_answered(points: Variant) -> void:
	current_points_total += points


func _on_final_question_panel_finished() -> void:
	$CanvasLayer/FinalQuestionPanel.hide()
	$CanvasLayer/GameoverPanel.show()
	
	$CanvasLayer/GameoverPanel/TotalPoints.text = 'Total Points: %d' % current_points_total
	
	if current_points_total <= 59:
		$CanvasLayer/GameoverPanel/RankName.text = 'Investigation Complete'
		$CanvasLayer/GameoverPanel/Detail.text = 'Review how metadata, cookies, VPNs, and public information can support or mislead an investigation.'
	elif current_points_total <= 84:
		$CanvasLayer/GameoverPanel/RankName.text = 'Case Solved'
		$CanvasLayer/GameoverPanel/Detail.text = 'Your conclusion was correct, but some evidence could have been evaluated more carefully.'
	elif current_points_total <= 100:
		$CanvasLayer/GameoverPanel/RankName.text = 'Digital Investigator'
		$CanvasLayer/GameoverPanel/Detail.text = 'You connected several independent clues and correctly identified misleading evidence.'
