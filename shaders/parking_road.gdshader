shader_type spatial;

uniform sampler2D image : filter_nearest;
uniform sampler2D noise_texture;
uniform float noise_uv_scale : hint_range(0.0, 10.0, 0.01) = 1.0;
uniform float noise_scale : hint_range(0.0, 10.0, 0.01) = 1.0;

void fragment() {
	vec3 img = texture(image, UV).rgb;
	vec3 n = texture(noise_texture, UV * noise_uv_scale).rgb;
	
	if (n.r > noise_scale) {
		n = vec3(1.0);
	} else {
		n = vec3(0.0);
	}
	
	ALBEDO = img;
	ROUGHNESS = n.r;
}
