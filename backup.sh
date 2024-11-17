#! /bin/bash

# Cread un script Cron que realice una copia de seguridad incremental de la carpeta Seguridad cada
# día a las 12 del mediodía. Cada copia se deberá realizar en una carpeta distinta, cuyo nombre será
# la fecha del día que se hizo la respectiva copia.

# Definir variables
ORIGEN="/home/jorge/Datos/"
DESTINO="/var/tmp/Backups/$(date +%d-%m-%Y)/"
FECHA_ANTERIOR="/var/tmp/Backups/$(date -d "yesterday" +%d-%m-%Y)/"

# Crear directorio de destino si no existe
mkdir -p "$DESTINO"

# Verificar si existe la copia de seguridad de ayer
if [ -d "$FECHA_ANTERIOR" ]; then
    # Realizar la copia de seguridad incremental
    rsync -av --link-dest="$FECHA_ANTERIOR" "$ORIGEN" "$DESTINO"
else
    # Si no existe la copia de seguridad de ayer, hacer una copia completa
    rsync -av "$ORIGEN" "$DESTINO"
fi
