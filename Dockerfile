FROM python:3.11-slim

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Instala MkDocs Material y extensiones recomendadas
RUN pip install --no-cache-dir mkdocs-material[recommended]
