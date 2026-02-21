shader_type canvas_item;

uniform vec3 fill_color: source_color;
uniform vec3 top_color: source_color;
uniform sampler2D noise_sampler;
uniform sampler2D sprite_sampler;
uniform float progress: hint_range(0.0, 1.0, 0.001);
uniform float liquid_effect_amplitude: hint_range(0.0, 100.0, 0.001) = 2.0;
uniform float liquid_effect_period: hint_range(0.0, 100.0, 0.001) = 2.0;


float wave(float x, float amplitude, float period) {
	return amplitude * sin(period * x);
}

vec4 orb(vec2 p) {
	// Convert from top-left to bottom-left coordinates the Y.
	float y = 1.0 - p.y;
	
	// Sample y + (sin(uv.x + (amplitude * TIME))) to see if we can add a bit more progress.
	float noise = texture(noise_sampler, vec2(p.x, y)).r;
	y = y + wave(TIME + noise + p.x, liquid_effect_amplitude, liquid_effect_period) * 0.01;
	float v = step(y, progress);
	float a = v * texture(sprite_sampler, p).a * 0.75;

	return vec4(v * fill_color, a);
}

void fragment() {
	COLOR = orb(UV);
}
