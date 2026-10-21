# runpod-blender

RunPod pod image for headless Blender (Eevee/Cycles) rendering: `runpod/base` (SSH via `PUBLIC_KEY`) + Blender 5.1.2.

Image: `ghcr.io/jamesyu/runpod-blender:5.1.2`. Expose `22/tcp`; `NVIDIA_DRIVER_CAPABILITIES=all` is baked in so Eevee gets the driver's EGL libraries.

`/opt/assets/cast/<name>.blend` (alex maya kenji rosa david lin walt grace) and `/opt/assets/human.blend` (= alex): the hd3d-shorts presenter cast, MakeHuman/MPFB2 from the CC0 system assets, textures packed. Downloaded from the `assets-v1` release at build time.
