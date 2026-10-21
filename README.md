# runpod-blender

RunPod pod image for headless Blender (Eevee/Cycles) rendering: `runpod/base` (SSH via `PUBLIC_KEY`) + Blender 5.1.2.

Image: `ghcr.io/jamesyu/runpod-blender:5.1.2`. Expose `22/tcp`; `NVIDIA_DRIVER_CAPABILITIES=all` is baked in so Eevee gets the driver's EGL libraries.
