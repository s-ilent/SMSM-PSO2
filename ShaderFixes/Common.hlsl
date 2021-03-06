#ifndef COMMON_INCLUDED
#define COMMON_INCLUDED

// R2 noise pattern
float dither_r(float2 pixel) {
    const float a1 = 0.75487766624669276;
    const float a2 = 0.569840290998;
    return frac(a1 * float(pixel.x) + a2 * float(pixel.y));
}

// Interleaved gradient noise
float interleaved_gradient(float2 uv)
{
  float3 magic = float3(0.06711056, 0.00583715, 52.9829189);
  return frac(magic.z * frac(dot(uv, magic.xy)));
}

// Remap to triangular distribution
float remap_tri(float z) {
    return z >= 0.5 ? 2.-2.*z : 2.*z;
}

#endif // COMMON_INCLUDED