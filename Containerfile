# ------------------------------------------------------------
# Kali Linux con escritorio XFCE, VNC y acceso web (noVNC)
# Optimizado para HomeLab en Fedora 42 con Podman
# Incluye herramientas de Pentesting, escritorio gráfico
# Acceso remoto por navegador y límites de recursos opcionales
# ------------------------------------------------------------

# Imagen base oficial de Kali Linux
FROM kalilinux/kali-rolling

# Evita prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Configura repositorio completo de Kali (por seguridad y cobertura)
RUN echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list

# Instala escritorio XFCE, VNC, herramientas top10 y utilidades
RUN apt update && apt install -y \
    kali-desktop-xfce kali-linux-headless kali-tools-top10 \
    tightvncserver novnc websockify dbus-x11 \
    xfce4 xfce4-goodies \
    x11-xserver-utils \
    wget curl git net-tools sudo htop && \
    apt clean

# Crea usuario "kali" y establece contraseñas
RUN useradd -m -s /bin/bash kali && \
    echo "kali:kali" | chpasswd && \
    echo "root:kali123" | chpasswd && \
    usermod -aG sudo kali && \
    echo "kali ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/kali && \
    chmod 0440 /etc/sudoers.d/kali

# Configura entorno gráfico y contraseña VNC
RUN mkdir -p /home/kali/.vnc && \
    printf '#!/bin/bash\nxrdb $HOME/.Xresources\nexport DISPLAY=:1\nstartxfce4 &\n' > /home/kali/.vnc/xstartup && \
    chmod +x /home/kali/.vnc/xstartup && \
    echo "kali123" | vncpasswd -f > /home/kali/.vnc/passwd && \
    chmod 600 /home/kali/.vnc/passwd && \
    chown -R kali:kali /home/kali

# Expone los puertos para VNC (5901) y noVNC (6080)
EXPOSE 5901 6080

# Inicia el servidor VNC y lanza noVNC (websockify)
# Se usa resolución 1920x1080 por defecto
CMD ["/bin/bash", "-c", "su - kali -c 'vncserver :1 -geometry 1920x1080 -depth 24'; websockify --web=/usr/share/novnc/ 6080 localhost:5901"]

