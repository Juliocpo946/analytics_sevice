# Usa una imagen base de Python
FROM python:3.11-slim

# Establece el directorio de trabajo
WORKDIR /app

# Instala dependencias del sistema necesarias para compilar algunos paquetes de Python
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copia el archivo de requisitos
COPY requirements.txt .

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código de la aplicación
COPY . .

# Crea el directorio para modelos si no existe
RUN mkdir -p /app/models

# Expone el puerto que usa la aplicación
EXPOSE 3007

# Variables de entorno por defecto
ENV HOST=0.0.0.0
ENV PORT=3007
ENV PYTHONUNBUFFERED=1

# Comando para ejecutar la aplicación
CMD ["python", "main.py"]