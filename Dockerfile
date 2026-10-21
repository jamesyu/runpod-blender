# RunPod image for rendering Totally Hypothetical HD 3D Shorts: RunPod base (sshd + PUBLIC_KEY handling) + Blender, ready for headless Eevee.
FROM runpod/base:1.4.0-ubuntu2404

ARG BLENDER_VERSION=5.1.2
ARG BLENDER_SERIES=5.1

RUN apt-get update && apt-get install -y --no-install-recommends \
        libxrender1 libxi6 libxkbcommon0 libxkbcommon-x11-0 libsm6 libxxf86vm1 libxfixes3 \
        libgl1 libegl1 libwayland-client0 libvulkan1 rsync xz-utils curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://download.blender.org/release/Blender${BLENDER_SERIES}/blender-${BLENDER_VERSION}-linux-x64.tar.xz" -o /tmp/b.tar.xz \
    && mkdir -p /opt/blender && tar -xJf /tmp/b.tar.xz -C /opt/blender --strip-components=1 \
    && rm /tmp/b.tar.xz && ln -s /opt/blender/blender /usr/local/bin/blender

# The realistic presenter (MakeHuman/MPFB2 built from the CC0 system assets, textures packed) so pods need no upload.
COPY assets/human.blend /opt/assets/human.blend

# Eevee needs the driver's EGL/GL libraries mounted into the container, not just compute.
ENV NVIDIA_DRIVER_CAPABILITIES=all
RUN blender -b --version | head -1
