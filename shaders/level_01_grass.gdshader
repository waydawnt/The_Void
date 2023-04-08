shader_type spatial;
render_mode cull_disabled, depth_draw_opaque;

uniform sampler2D grass_texture : filter_nearest;

void vertex() {
	if (UV.y < 1.0) {
		VERTEX.x += sin(UV.y + TIME * 2.0) * 0.1;
	}
}


void fragment() {
	vec4 grass = texture(grass_texture, UV);

	ALBEDO = grass.rgb;
	ALPHA = grass.a;
}

