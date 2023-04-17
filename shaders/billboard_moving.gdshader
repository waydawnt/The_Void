shader_type spatial;

uniform sampler2D image;
uniform float x_scale = 1.0;
uniform float y_scale = 1.0;
uniform float x_offset = 0.0;
uniform float y_offset = 0.0;
uniform float moving_speed = 0.0;
uniform float x_uv_scale : hint_range(0.0, 100.0, 0.01) = 1.0;
uniform float dot_scale : hint_range(0.0, 1000.0, 1.0) = 100.0;
uniform vec3 emission_color : source_color = vec3(0.2, 0.82, 0.98);


void fragment() {
	vec2 uv = UV;
	uv -= 0.5;
	uv.x *= x_uv_scale;
	vec2 st = fract(uv * dot_scale) - 0.5;
	float d = length(st);
	float c = d;
	
	if (d < 0.4) {
		c = 1.0;
	} else {
		c = 0.0;
	}
	
	vec2 i_uv = UV;
	i_uv.x += TIME * moving_speed;
	vec3 img = texture(image, vec2(i_uv.x * x_scale, i_uv.y * y_scale) - vec2(x_offset, y_offset)).rgb;
	vec3 i = vec3(c);
	
	if (i == vec3(1.0)) {
		ALBEDO = img;
		EMISSION = img;
	} else {
		ALBEDO = vec3(0.0);
		EMISSION = emission_color;
	}
}
