varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 lightPosition;
uniform vec4 lightColor;
uniform float lightRange;

varying vec3 v_worldPosition;
varying vec3 v_worldNormal;

void main() {
    vec4 starting_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    
    vec4 lightAmbient = vec4(0.25, 0.25, 0.25, 1.);
    
    // Point light stuff
    vec3 lightDir = v_worldPosition - lightPosition;
    float lightDist = length(lightDir);
    float att = max((lightRange - lightDist) / lightRange, 0.);
    
    lightDir = normalize(-lightDir);
    float NdotL = max(dot(v_worldNormal, lightDir), 0.);
    
    vec4 final_color = starting_color * vec4(min(lightAmbient + att * lightColor * NdotL, vec4(1.)).rgb, starting_color.a);
    gl_FragColor = final_color;
}
