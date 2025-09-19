#!/bin/bash

# Configuración
BASE_URL="https://www.loterianacional.gob.mx"
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
FECHA=$(date +%Y%m%d)

# URLs de descarga (ajusta según la estructura real del sitio)
URL_MELATE="${BASE_URL}/Home/Historicos?ARHP=TQBlAGwAYQB0AGUA"
URL_REVANCHA="${BASE_URL}/Home/Historicos?ARHP=UgBlAHYAYQBuAGMAaABhAA=="

# Función para descargar
descargar_csv() {
    local url="$1"
    local nombre="$2"
    
    echo "⬇️ Descargando $nombre..."
    wget --user-agent="$USER_AGENT" --no-check-certificate -q --show-progress "$url" -O "${FECHA}_${nombre}.csv"
    
    if [ $? -eq 0 ]; then
        echo "✅ $nombre descargado: ${FECHA}_${nombre}.csv"
    else
        echo "❌ Falló la descarga de $nombre"
    fi
}

# Descargar ambos
descargar_csv "$URL_MELATE" "melate" &
descargar_csv "$URL_REVANCHA" "revancha" &
wait

# Verificar archivos descargados
echo -e "\n📁 Archivos generados:"
ls -lh "${FECHA}"_*.csv