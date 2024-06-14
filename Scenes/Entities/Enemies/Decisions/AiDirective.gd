extends Resource
class_name AiDirective

var enemy : Enemy
var directives : Array[Directive]

func constructor(m_enemy : Enemy, m_directives : Array[Directive]) -> AiDirective:
	self.enemy = m_enemy
	self.directives = m_directives
	return self

func execute():
	var max_weight := -INF
	var best_directive : Directive
	for d in self.directives:
		var _weight = d.decide(self.enemy)
		if _weight > max_weight:
			max_weight = _weight
			best_directive = d
	if max_weight > 0:
		#print(max_weight)
		#print(best_directive.get_script().resource_path)
		best_directive.apply(enemy)
	#else:
		#print("skip")
	
