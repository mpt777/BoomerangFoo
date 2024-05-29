extends Node
class_name EtTween

var _tween : Tween

func tween():
	if not self._tween:
		self._tween = create_tween()
		#self._tween.kill() # Abort the previous animation.
	#self._tween = create_tween()
	return self._tween
