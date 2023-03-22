# Imagen base con Python 3.11
FROM python:3.11-slim-buster

# Instala los paquetes necesarios para compilar algunas bibliotecas
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get clean && \
    # elimina todos los archivos de lista de paquetes del cache de apt-get -recursivamente -sin_preguntar
    rm -rf /var/lib/apt/lists/* 

# Instala las bibliotecas habituales para análisis de datos
RUN pip install pandas scikit-learn scipy numpy matplotlib jupyter

# Expone el puerto 8888 para acceder a Jupyter
EXPOSE 8888

# Configuración del servidor
ENV JUPYTER_PASSWORD=1234

# Crea un directorio para el trabajo en Jupyter
RUN mkdir /work

# Establece el directorio de trabajo
WORKDIR /work

# Nombre de la imagen
LABEL name="cdpython"
LABEL org.opencontainers.image.source=https://github.com/eloypripan/BigData1Dockers
LABEL org.opencontainers.image.description="cdpython"

# Ejecuta Jupyter al iniciar el contenedor
#RUN ["jupyter", "notebook", "--generate-config"]
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]

#Construir la imagen
# docker build -t cdpython .
# docker build -t cdpython cdpython.dockerfile
#Ejecuto imagen con puertos local:contenedor
# docker run -p 8888:8888 -v /ruta/local:/work cdpython

#Entrar con el navegador
# http://localhost:8888?token=