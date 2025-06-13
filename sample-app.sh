#!/bin/bash
# Cette ligne indique que le script doit être exécuté avec bash

# Crée un dossier temporaire et stocke son chemin dans la variable TEMP_DIR
TEMP_DIR=$(mktemp -d)

# Copie le fichier principal de l'application Flask dans le dossier temporaire
cp sample_app.py "$TEMP_DIR/"

# Copie le dossier templates (contenant les fichiers HTML) dans le dossier temporaire
cp -r templates "$TEMP_DIR/"

# Copie le dossier static (contenant les fichiers CSS, images, etc.) dans le dossier temporaire
cp -r static "$TEMP_DIR/"

# Crée un fichier Dockerfile dans le dossier temporaire
cat > "$TEMP_DIR/Dockerfile" << 'EOF'
# Utilise l'image Python 3.9 comme base (version légère)
FROM python:3.9-slim

# Définit le dossier de travail dans le conteneur
WORKDIR /app

# Copie tous les fichiers du dossier temporaire vers le conteneur
COPY . .

# Installe Flask via pip
RUN pip install flask

# Indique que l'application écoutera sur le port 5000
EXPOSE 5000

# Commande qui sera exécutée au démarrage du conteneur
CMD ["python", "sample_app.py"]
EOF

# Construit l'image Docker avec le tag 'sample-app'
docker build -t sample-app "$TEMP_DIR"

# Lance un conteneur à partir de l'image
# -p 5000:5000 : fait correspondre le port 5000 du conteneur au port 5000 de votre machine
docker run -p 5000:5000 sample-app

# Supprime le dossier temporaire et son contenu
rm -rf "$TEMP_DIR"