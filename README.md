A messy shader modification for Phantasy Star Online 2. 

## Features
1. To reduce banding artifacts ingame, colour dithering has been implemented. <br>Note that because many textures in PSO2 are stored in low quality and weren't changed with the engine upgrade, the surfaces of objects and skyboxes will still have visible banding.
2. Added a patch to the shader used for Mags to reimplement their emission. 
3. The emissive strength of some weapon shaders has been increased, allowing them to cast bloom lighting.
4. Added a scattering pattern to motion blur to make it look less stepped.

![Dithering](https://github.com/s-ilent/SMSM-PSO2/blob/main/.images/pso2_dither.png?raw=true)

![Emission on Mags.](https://github.com/s-ilent/SMSM-PSO2/blob/main/.images/pso2_mags.png?raw=true)

## Usage
This relies on 3DMigoto to do the hard work.
1. Download and install 3DMigoto from <https://github.com/bo3b/3Dmigoto/releases>. 
2. 3DMigoto comes with 3 folders. Extract the contents of the `x64` folder next to `pso2.exe`, so they are in the same place. 

3DMigoto is a shader patching tool. By default, it is configured to let you hunt for shaders. <br>
If you are not planning on doing modding yourself, disable the features in the included d3dx.ini. I recommend:
1. Disable `hunting`, `calls`, and `input`.
2. Enable `cache_shaders`.

Finally, place the ShaderFixes folder from this repo next to `pso2.exe`, overwriting the folder created by 3DMigoto. 

## Notes
Changes to the rendering engine in the future that affect shaders will cause the affected shaders to have new hashes, which will result in the new versions not being patched. In that scenario, the patches will need to be redone.

As PSO2 was only just upgraded to the new renderer, I'm hoping Sega will fix some of the bugs themselves.

Transparent objects rendered after the normal deferred passes will fail to dump shaders. I think it's because the result is too big, as transparent objects have really really big shaders that try to calculate all the lighting for them. It seems kind of excessive, but for non-emissive objects it makes sense. At the same time, I think it might be a bottleneck for old GPUs...

A number of passes, such as FXAA and TAA, are rendered after the final output is composited to sRGB space. 

Most materials will start with a similar piece of code to do dithering when the camera is too close. This is also used for some types of transparency on items.

The buffer layout opaque shaders write to seems to be like this. 
* o0.xyz : Albedo
* o0.w : Scene-dependant ambient power
* o1.x : Metallic or specular intensity
* o1.y : Roughness
* o1.z : If >0.5, the material is specular. Otherwise, it is metallic.
* o1.w : Occlusion
* o2.xyz : Normals
* o2.w : Unused
* o3.xyz : Emission
* o3.w : Unused
* o4.xy: Screen-space blur factor (i.e. velocity for motion blur)
* o4.zw : Unused

Note that non-metallic objects have a specular colour of white.

## License
The unique code in this repository is under the MIT license. 

Some code in this repository is decompiled shader code. Please note that it is used under fair use.
