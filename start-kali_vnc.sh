podman run -d \
  --name kali-vnc \
  -p 5901:5901 -p 6080:6080 \
  --memory=4g \
  --cpus=2 \
  --security-opt label=disable \
  -v kali-home:/home/kali \
  kali-vnc

