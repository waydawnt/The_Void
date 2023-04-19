shader_type spatial;
render_mode depth_draw_opaque;

uniform sampler2D image : filter_nearest;
uniform float emission_strength : hint_range(0.0, 10.0, 0.1) = 1.0;

void fragment() {
	vec4 img = texture(image, UV);
	
	if (img.rgb == vec3(1.0)) {
		EMISSION = vec3(1.0) * emission_strength;
	}
	
	ALBEDO = img.rgb;
	ALPHA = img.a;
}
