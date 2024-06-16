extends Resource
class_name DirectiveLayer

var enemy : Enemy
@export var directives : Array[Directive]
var best_directive : Directive
var applied := false

func constructor(m_enemy : Enemy) -> DirectiveLayer:
	self.enemy = m_enemy
	self.make_unique()
	return self
	
func make_unique():
	var _directives : Array[Directive]
	for d in self.directives:
		var _d = d.duplicate(true)
		_d.enemy = self.enemy
		_directives.append(_d)
	self.directives = _directives
	
	for d in self.directives:
		d.ready()

func execute():
	if applied and best_directive:
		best_directive.unapply()
		applied = false
		
	var max_weight := -INF
	for d in self.directives:
		var _weight = d.decide(self.enemy)
		if _weight > max_weight:
			max_weight = _weight
			best_directive = d
	if max_weight > 0:
		#print(max_weight)
		#print(best_directive.get_script().resource_path)
		best_directive.apply(enemy)
		applied = true
	#else:
		#print("skip")

