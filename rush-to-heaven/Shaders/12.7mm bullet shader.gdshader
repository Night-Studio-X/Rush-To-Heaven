shader_type spatial;
render_mode unshaded, blend_add, depth_draw_never, cull_disabled;

uniform vec4 trail_color : source_color = vec4(1.0, 0.7, 0.2, 1.0);
uniform float intensity = 7.0;
uniform float trail_length = 1.5;

varying float fade;

void vertex() {
	fade = clamp(VERTEX.z / trail_length + 0.5, 0.0, 1.0);
}

void fragment() {
	float strength = 1.0 - fade;
	ALBEDO = trail_color.rgb * intensity * strength;
}