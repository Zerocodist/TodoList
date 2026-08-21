#version 450

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float time;
};

layout(location = 0) in vec2 qt_TexCoord;

layout(location = 0) out vec4 fragColor;


void main()
{
    vec2 uv = qt_TexCoord;

    float t = time;

    vec2 disortedUV = uv;


    disortedUV.x += sin(uv.y * 6.0 + t * 0.45) * 0.012;
    disortedUV.y += cos(uv.x * 5.0 + t * 0.35) * 0.012;

    uv = disortedUV;


    vec2 center1 = vec2(0.30, 0.40);
    vec2 center2 = vec2(0.78, 0.68);

    center1 += vec2(
                sin(t * 0.45) * 0.07,
                cos(t * 0.35) * 0.045
    );

    center2 += vec2(
                cos(t * 0.30) * 0.055,
                sin(t * 0.50) * 0.065
    );


    float dist1 = distance(uv, center1);
    float dist2 = distance(uv, center2);


    float glow1 = smoothstep(
                0.75,
                0.0,
                dist1
    );

    float glow2 = smoothstep(
                0.65,
                0.0,
                dist2

    );

    float inner1 = smoothstep(
                0.35,
                0.0,
                dist1
    );

    float inner2 = smoothstep(
                0.30,
                0.0,
                dist2
    );

    vec3 background = vec3(
                0.055,
                0.058,
                0.065
    );

    vec3 light = vec3(
                0.55,
                0.56,
                0.58
    );

    vec3 white = vec3(
                0.85,
                0.86,
                0.88
    );


    vec3 color = background;

    color += light * glow1 * 0.22;
    color += light * glow2 * 0.18;

    color += white * inner1 * 0.10;
    color += white * inner2 * 0.08;


    float ambient =
            sin(t * 0.35 + uv.x * 3.0 + uv.y * 2.0)
            * 0.5
            + 0.5;

    color += vec3(
                0.018,
                0.018,
                0.020
    ) * ambient;

    fragColor = vec4(color, qt_Opacity);
}