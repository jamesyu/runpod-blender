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

# The hd3d presenter cast (MakeHuman/MPFB2 from the CC0 system assets, textures packed, logos painted out), so pods
# need no upload. /opt/assets/cast/<name>.blend; human.blend = alex (the original presenter).
RUN mkdir -p /opt/assets/cast && curl -fsSL https://github.com/jamesyu/runpod-blender/releases/download/assets-v1/cast-v1.tar \
    | tar -x -C /opt/assets/cast && ln -s /opt/assets/cast/alex.blend /opt/assets/human.blend && ls /opt/assets/cast

# Eevee needs the driver's EGL/GL libraries mounted into the container, not just compute.
ENV NVIDIA_DRIVER_CAPABILITIES=all
RUN blender -b --version | head -1
