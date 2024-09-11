shader_type spatial;

uniform vec3 player_position : hint_range(-100.0, 100.0);
uniform float clip_radius = 1.0;
uniform sampler2D noise_texture : hint_albedo;
uniform float noise_scale = 1.0; // Scale of the noise texture
uniform float noise_strength = 0.2; // Strength of the noise effect
uniform vec3 camera_position : hint_range(-100.0, 100.0);
uniform vec3 camera_direction : hint_color;

void fragment() {
    // Transform vertex to camera space
    vec3 vertex_camera_space = (CAMERA_MATRIX * vec4(VERTEX, 1.0)).xyz;
    vec3 player_camera_space = (CAMERA_MATRIX * vec4(player_position, 1.0)).xyz;
    
    // Calculate the distance in 2D (screen space)
    vec2 screen_space_distance = (vertex_camera_space.xy - player_camera_space.xy);
    
    // Create a circular mask
    float distance = length(screen_space_distance);
    
    // Sample the noise texture
    vec2 uv = screen_space_distance * noise_scale;
    float noise = texture(noise_texture, uv).r;
    
    // Modify the radius based on the noise texture
    float modified_radius = clip_radius + noise * noise_strength; // Adjust the multiplier for more effect
    
    // Smooth edge using smoothstep
    float edge = smoothstep(modified_radius - noise_strength, modified_radius, distance);
    
    // Apply the smooth edge effect
    ALBEDO *= edge;
    
    // If inside the modified mask, discard the fragment
    if (distance < modified_radius) {
        discard;
    }
}