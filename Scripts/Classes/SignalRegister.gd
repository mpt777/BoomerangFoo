extends Node
class_name SignalRegister

var signals = []

func register(signal_name : String, function : Callable) -> void:
	add_user_signal(signal_name)
	connect(signal_name, function)
	signals.append(signal_name)
	#signals.push({
		#"signal":signal_name,
		#"callable": function
	#})
	
func deregister(signal_name : String, function : Callable) -> void:
	disconnect(signal_name, function)
	#signals.erases(signal_name)
	
#func emit(signal_name : String) -> Signal:
	#return signals[signal_name]

