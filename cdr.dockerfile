# Imagen base
FROM r-base:latest

# Instala los paquetes necesarios
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
        libfontconfig1-dev libicu-dev \
        libharfbuzz-dev libfribidi-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libmariadb-dev

# elimina todos los archivos de lista de paquetes del cache de apt-get -recursivamente -sin_preguntar
RUN rm -rf /var/lib/apt/lists/*
RUN R -e "install.packages(c('tidyverse', 'caret', 'RSNNS', 'frbs', 'FSinR', 'fable'), repos='https://cran.rstudio.com/')"

# Configuración del servidor
ENV R_PROFILE_USER='--vanilla'

# Puerto de exposición
EXPOSE 8787

# Establece el directorio de trabajo
WORKDIR /app

# Volumen de los notebooks
VOLUME /app/notebooks

# Nombre de la imagen
LABEL name="cdr"
LABEL org.opencontainers.image.source=https://github.com/eloypripan/BigData1Dockers
LABEL org.opencontainers.image.description="cdr"

# Start R console by default
CMD ["R"]
#CMD ["/bin/bash"]

# docker build -t cdr .
# docker build -t cdr cdr.dockerfile