shader_type particles;

uniform float angle_step;
uniform float initial_velocity;
uniform float velocity_decay;
uniform float size_decay;
uniform vec3 scale;
uniform vec4 color: source_color;

vec3 decay_velocity(vec3 velocity) {
	return velocity *= velocity_decay;
}
mat4 decay_size(mat4 transform, float lifetime) {
	transform[0].xyz *= pow(size_decay, lifetime);
	transform[1].xyz *= pow(size_decay, lifetime);
	transform[2].xyz *= pow(size_decay, lifetime);
	return transform;
}

void start(){
    float degree_to_rad = PI / 180.0;
	
    if(RESTART_VELOCITY){
	    float angle1_rad = float(INDEX) * angle_step * degree_to_rad;
	    vec3 rot = vec3(cos(angle1_rad), sin(angle1_rad), 0.0);
	    VELOCITY = rot * initial_velocity;
	}
    if(RESTART_POSITION){
	    TRANSFORM[3] = vec4(0);
    }
	if (RESTART_ROT_SCALE) {
		TRANSFORM[0].xyz = vec3(1.0, 0.0, 0.0);
		TRANSFORM[1].xyz = vec3(0.0, 1.0, 0.0);
		TRANSFORM[2].xyz = vec3(0.0, 0.0, 1.0);
	}
	
	TRANSFORM[0].xyz *= sign(scale.x) * max(abs(scale.x), 0.001);
	TRANSFORM[1].xyz *= sign(scale.y) * max(abs(scale.y), 0.001);
	TRANSFORM[2].xyz *= sign(scale.z) * max(abs(scale.z), 0.001);
	
	COLOR = color;
}
void process(){
	VELOCITY = decay_velocity(VELOCITY);
	TRANSFORM = decay_size(TRANSFORM, LIFETIME);
}
