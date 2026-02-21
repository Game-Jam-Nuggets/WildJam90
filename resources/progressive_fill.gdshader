shader_type canvas_item;

uniform vec3 fill_color: source_color;
uniform vec3 top_color: source_color;

uniform sampler2D background_texture;
uniform sampler2D foreground_texture;
uniform sampler2D sprite_sampler;

uniform float progress: hint_range(0.0, 1.0, 0.001) = 0.1;
uniform float liquid_effect_amplitude: hint_range(0.0, 100.0, 0.001) = 2.0;
uniform float liquid_effect_period: hint_range(0.0, 100.0, 0.001) = 2.0;
uniform float liquid_highlight_strength: hint_range(0.0, 1.0, 0.001) = 0.6;
uniform float liquid_highlight_width: hint_range(0.0, 0.1, 0.0001) = 0.02;

// creates a wave effect a time x given an amplitude (up and down bits) and period
// (how long a given wave is).
float wave(float x, float amplitude, float period) {
    return amplitude * sin(period * x);
}

// given the point, find what corresponding y it is actually.
float surface_y(float x) {
    return progress + wave(TIME + x, liquid_effect_amplitude, liquid_effect_period) * 0.01;
}

// the main fill of the piece.
vec4 bottle_fill(vec2 p) {
    float y = 1.0 - p.y;
    float y_surface = surface_y(p.x);
    float v = step(y, y_surface);
    float a = v * texture(sprite_sampler, p).a;
    return vec4(v * fill_color, a);
}

// create that highlight on the top of the liquid.
vec4 liquid_highlight(vec2 p) {
    float mask = texture(sprite_sampler, p).a;
    float y = 1.0 - p.y;
    float y_surface = surface_y(p.x);
    float dist = y - y_surface;
    float band = smoothstep(liquid_highlight_width, 0.0, abs(dist)) * step(0.0, dist);
    float intensity = band * liquid_highlight_strength * mask;
    return vec4(vec3(1.0), intensity);
}

// blend two colors together
// the basic idea is that blending 2 colors together can't be just a + b or a * b.
// people smarter than me came up with this thing called Porter-Duff, which
// is a way to do this properly.
// read more here: https://ssp.impulsetrain.com/porterduff.html
vec4 blend_over(vec4 src, vec4 dst) {
    float out_a = src.a + dst.a * (1.0 - src.a);
    if (out_a < 0.0001) return vec4(0.0);
    vec3 out_rgb = (src.rgb * src.a + dst.rgb * dst.a * (1.0 - src.a)) / out_a;
    return vec4(out_rgb, out_a);
}

void fragment() {
    vec4 background = texture(background_texture, UV);
    vec4 fill = bottle_fill(UV);
    vec4 glass = texture(foreground_texture, UV);
    vec4 lh = liquid_highlight(UV);

    vec4 result = background;
    result = blend_over(fill, result);   	// the juice.
    result = blend_over(lh, result);		// highlighting the top of the bottle.
    result = blend_over(glass, result);	 	// glass.
    COLOR = vec4(result.rgb, result.a);
}