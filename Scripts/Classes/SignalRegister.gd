extends Node
class_name SignalRegister

var signals = []

func register(signal_name : String, function : Callable) -> void:
	if not has_user_signal(signal_name):
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
	
#func emit(signal_name : String, args : Array = []) -> void:
	#if not is_connected(signal_name):
		#return
		#
	#if args:
		#callv("emit_signal", args)
	#else:
		#self.emit_signal(signal_name)
	
	#self.emit_signal(signal_name, *args)

