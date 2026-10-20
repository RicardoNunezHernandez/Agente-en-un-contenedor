# Imagen base: Linux minimo con Python 3.12 (la misma version del workflow)
FROM python:3.12-slim

# Muestra cada print() al momento en los registros (docker logs)
ENV PYTHONUNBUFFERED=1

# Carpeta de trabajo dentro del contenedor (Docker la crea si no existe)
WORKDIR /app

# Primero solo requirements.txt: si no cambia, Docker reutiliza
# la capa del pip install y la reconstruccion tarda segundos
COPY requirements.txt .

# Instala las librerias sin guardar archivos temporales de pip
RUN pip install --no-cache-dir -r requirements.txt

# Ahora si, el script del agente
COPY agente_soporte.py .

# Comando al arrancar. Lo que se escriba despues del nombre de la
# imagen en "docker run" (por ejemplo --una-vez) se agrega al final
ENTRYPOINT ["python", "agente_soporte.py"]
