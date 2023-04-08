shader_type spatial;

uniform sampler2D color;
uniform sampler2D roughess;
uniform sampler2D normal_map;

void fragment() {
	vec2 uv = UV;
	uv.x *= 10.0;
	
	vec4 tex = texture(color, uv);
	vec3 normals = texture(normal_map, uv).rgb;
	float rough = texture(roughess, uv).r;
	
	ALBEDO = tex.rgb;
	ROUGHNESS = rough;
	NORMAL_MAP = normals;
}
