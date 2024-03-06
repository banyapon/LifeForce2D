extends Label

func _process(delta):
	self.text = str("SCORE: ", Global.score)
	pass
