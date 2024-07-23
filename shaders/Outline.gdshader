shader_type spatial;
render_mode cull_front, unshaded;

uniform vec4 outline_color : source_color;
uniform float outline_width = 5.0;
uniform bool enabled;
void vertex() {
	if (enabled){
			vec4 clip_position = PROJECTION_MATRIX * (MODELVIEW_MATRIX * vec4(VERTEX, 1.0));
	vec3 clip_normal = mat3(PROJECTION_MATRIX) * (mat3(MODELVIEW_MATRIX) * NORMAL);
	float outline = sin(TIME*5.0) * -3.0 + outline_width;
	vec2 offset = normalize(clip_normal.xy) / VIEWPORT_SIZE * clip_position.w * outline * 2.0;
	
	clip_position.xy += offset;
	
	POSITION = clip_position;
	}
}
void fragment() {
	ALBEDO = outline_color.rgb * 6.0;
	if (outline_color.a < 1.0) {
		ALPHA = outline_color.a;
	}
}