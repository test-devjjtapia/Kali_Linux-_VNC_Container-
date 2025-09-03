# Kali Linux VNC Container 🐉

Un contenedor Docker/Podman optimizado que ejecuta Kali Linux con escritorio XFCE, servidor VNC y acceso web a través de noVNC. Perfecto para laboratorios de pentesting, práctica de ciberseguridad y acceso remoto desde cualquier navegador web.

## ✨ Características

- **Kali Linux Rolling** - Última versión con actualizaciones continuas
- **Escritorio XFCE** - Interfaz gráfica ligera y funcional
- **Acceso VNC** - Conexión directa por cliente VNC (puerto 5901)
- **Acceso Web (noVNC)** - Control total desde el navegador (puerto 6080)
- **Herramientas Top 10** - Suite completa de herramientas de pentesting preinstaladas
- **Usuario configurado** - Usuario `kali` con privilegios sudo
- **Persistencia de datos** - Volumen para mantener archivos y configuraciones

## 🚀 Inicio Rápido

### Prerrequisitos

- **Docker** o **Podman** instalado
- **4GB RAM** mínimo recomendado
- **2 CPU cores** para rendimiento óptimo

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/kali-vnc-container.git
cd kali-vnc-container
```

### 2. Construir la imagen

```bash
# Con Docker
docker build -t kali-vnc .

# Con Podman
podman build -t kali-vnc .
```

### 3. Ejecutar el contenedor

#### Opción A: Script automatizado (Recomendado)
```bash
chmod +x start-kali_vnc.sh
./start-kali_vnc.sh
```

#### Opción B: Comando manual con Docker
```bash
docker run -d \
  --name kali-vnc \
  -p 5901:5901 -p 6080:6080 \
  --memory=4g \
  --cpus=2 \
  -v kali-home:/home/kali \
  kali-vnc
```

#### Opción C: Comando manual con Podman
```bash
podman run -d \
  --name kali-vnc \
  -p 5901:5901 -p 6080:6080 \
  --memory=4g \
  --cpus=2 \
  --security-opt label=disable \
  -v kali-home:/home/kali \
  kali-vnc
```

## 🌐 Métodos de Acceso

### Acceso Web (noVNC) - Recomendado
1. Abrir navegador web
2. Ir a: `http://localhost:6080/vnc.html`
3. Hacer clic en **Connect**
4. Introducir contraseña: `kali123`

### Acceso VNC Directo
1. Instalar cliente VNC (TigerVNC, RealVNC, etc.)
2. Conectar a: `localhost:5901`
3. Introducir contraseña: `kali123`

## 🔐 Credenciales por Defecto

| Usuario | Contraseña | Privilegios |
|---------|------------|-------------|
| `kali`  | `kali`     | Usuario sudo |
| `root`  | `kali123`  | Administrador |
| VNC     | `kali123`  | Acceso remoto |

> ⚠️ **Importante**: Cambiar estas contraseñas en producción

## 📁 Estructura del Proyecto

```
kali-vnc-container/
├── Containerfile          # Definición de la imagen
├── start-kali_vnc.sh     # Script de inicio automatizado
└── README.md             # Documentación
```

## ⚙️ Configuración Avanzada

### Personalizar Resolución de Pantalla
```bash
# Modificar en Containerfile línea CMD, cambiar 1920x1080 por:
-geometry 1366x768    # HD
-geometry 2560x1440   # 2K
-geometry 3840x2160   # 4K
```

### Ajustar Recursos del Sistema
```bash
# Modificar en start-kali_vnc.sh:
--memory=8g           # Aumentar RAM a 8GB
--cpus=4             # Usar 4 núcleos de CPU
```

### Mapear Carpetas Locales
```bash
# Agregar volúmenes adicionales:
-v /ruta/local/tools:/home/kali/tools \
-v /ruta/local/projects:/home/kali/projects
```

## 🛠️ Herramientas Incluidas

El contenedor incluye las herramientas **Top 10 de Kali Linux**:

- **Nmap** - Escaneo de puertos y redes
- **Wireshark** - Análisis de tráfico de red  
- **Metasploit** - Framework de explotación
- **Burp Suite** - Pruebas de aplicaciones web
- **John the Ripper** - Cracking de contraseñas
- **Aircrack-ng** - Auditoría de redes WiFi
- **Nikto** - Escáner de vulnerabilidades web
- **SQLmap** - Explotación de inyección SQL
- Y muchas más...

## 🔧 Comandos Útiles

### Gestión del Contenedor
```bash
# Ver estado
podman ps -a

# Ver logs
podman logs kali-vnc

# Acceder por terminal
podman exec -it kali-vnc /bin/bash

# Parar contenedor
podman stop kali-vnc

# Reiniciar contenedor
podman restart kali-vnc

# Eliminar contenedor
podman rm kali-vnc

# Eliminar imagen
podman rmi kali-vnc
```

### Gestión de Volúmenes
```bash
# Listar volúmenes
podman volume ls

# Inspeccionar volumen
podman volume inspect kali-home

# Hacer backup del volumen
podman run --rm -v kali-home:/data -v $(pwd):/backup alpine tar czf /backup/kali-home-backup.tar.gz /data
```

## 🐛 Solución de Problemas

### El contenedor no inicia
```bash
# Verificar logs
podman logs kali-vnc

# Verificar puertos ocupados
netstat -tlnp | grep :6080
netstat -tlnp | grep :5901
```

### No puedo conectarme por web
1. Verificar que el contenedor esté ejecutándose: `podman ps`
2. Comprobar que el puerto 6080 esté expuesto
3. Probar con `http://127.0.0.1:6080/vnc.html`
4. Verificar firewall local

### Problemas de rendimiento
1. Aumentar memoria asignada: `--memory=6g`
2. Asignar más CPUs: `--cpus=4`
3. Reducir resolución de pantalla
4. Cerrar aplicaciones innecesarias en el host

### Pantalla negra o escritorio no carga
1. Reiniciar el contenedor: `podman restart kali-vnc`
2. Verificar que XFCE esté instalado correctamente
3. Revisar logs del servidor VNC

## 🚨 Consideraciones de Seguridad

- **Cambiar contraseñas por defecto** antes de usar en producción
- **No exponer puertos** a internet sin VPN o túnel SSH
- **Usar volúmenes cifrados** para datos sensibles
- **Actualizar regularmente** la imagen base
- **Limitar recursos** para evitar consumo excesivo

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para cambios importantes:

1. Fork el proyecto
2. Crear rama para feature (`git checkout -b feature/AmazingFeature`)
3. Commit cambios (`git commit -m 'Add: AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Crear Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver archivo `LICENSE` para más detalles.

## 🙏 Agradecimientos

- **Kali Linux Team** por la distribución base
- **noVNC Project** por la solución de acceso web
- **XFCE Desktop** por el entorno gráfico ligero

---

**⭐ Si este proyecto te fue útil, dale una estrella en GitHub!**

## 📧 Soporte

¿Problemas o sugerencias? Abre un [issue](https://github.com/tu-usuario/kali-vnc-container/issues) en GitHub.

---

*Desarrollado con ❤️ para la comunidad de ciberseguridad*
