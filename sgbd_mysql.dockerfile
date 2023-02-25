# Imagen base
FROM mysql:latest

# Puerto de exposición
EXPOSE 3306

# Configuración del servidor MySQL
ENV MYSQL_ROOT_PASSWORD=secretpassword #cualquier contraseña que quiera
ENV MYSQL_DATABASE=mydb 
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword

# Configuración para permitir consultas desde el exterior del contenedor
RUN echo "bind-address=0.0.0.0" >> /etc/mysql/conf.d/docker.cnf

# Nombre de la imagen
LABEL name="sgbd"

# Comando de inicio
CMD ["mysqld"]

#Construir la imagen con nombre sgbd y buscando en el path
# docker build -t sgbd .
# docker build -t sgbd 'sgbd_mysql.dockerfile'

#Ejecuto imagen sgbd, expongo puerto para consultas desde el exterior del contenedor 
#llamo al contenedor eloy-sgbd 
#puerto local:contenedor
# docker run -p 3306:3306 --name eloy-sgbd sgbd

