#!/bin/bash
# Este script de ejemplo realiza un respaldo de una base de datos de mariadb-server
# el respaldo se almacena en el directorio especificado en la variable backup_dir.

# Creado por Juan Reynoso Elias 18-06-2025
# Última modificación: 18-06-2025
# Live Love Hack

# Usuario de la base de datos
db_user="root"

# Contraseña del usuario
db_password=""

# Nombre de la base de datos que deseas respaldar
db_name="juan"

# Directorio donde guardarás el respaldo
backup_dir="/tmp"

# Fecha y hora en el formato deseado
backup_date=$(date +"%Y-%m-%d-%H:%M:%S")

# Nombre del archivo de respaldo
backup_file="$backup_dir/$db_name-$backup_date.sql"

# Comando para hacer el respaldo
mysqldump -u$db_user -p$db_password $db_name > $backup_file

# Verificar si el respaldo fue exitoso
if [ $? -eq 0 ]; then
  echo "Respaldo de la base de datos $db_name completado exitosamente."
else
  echo "Error al hacer el respaldo de la base de datos $db_name."
fi
