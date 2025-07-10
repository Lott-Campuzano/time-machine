#!/bin/bash
# Script de ejemplo que cifra un respaldo usando la herrmienta gocryptfs
# Creado por Juan Reynoso Elias 18-06-2025

# Configurar Rutas
# $HOME significa =>  /home/user


cifrada="$HOME/respaldos/cifrado"
montada="$HOME/respaldos/montado"
passfile="$HOME/scripts/pass_cifrado.txt"
backup_name="backup-$(date +%Y-%m-%d-T%H:%M:%S).tar.gz"
mypath="$HOME/scripts/"
docs="demo"

# Crear carpetas si no existen
mkdir -p "$cifrada"
mkdir -p "$montada"



# === MONTAJE CON CLAVE AUTOMÁTICA ===
echo "Montando carpeta cifrada..."
gocryptfs -passfile "$passfile" "$cifrada" "$montada" 



# === CREAR Y GUARDAR BACKUP ===
echo "Creando backup de $docs"
cd $mypath
tar -czvf "$montada/$backup_name"  "$docs" 


# === DESMONTAJE ===
fusermount -u "$montada"
echo "🔒 Carpeta desmontada."
