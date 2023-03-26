#Creo una función para instalar en caso de que no lo esten y luego cargar
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)){install.packages(new.pkg, dependencies = TRUE, repos='https://cran.rstudio.com/')}
  sapply(pkg, require, character.only = TRUE)
}

# Paquetes usados
packages <- c('tidyverse', 'caret', 'RSNNS', 'frbs', 'FSinR', 'fable')
#packages <- c("Amelia","car","caret","class","cluster","corrplot","dlookr","factoextra",
#              "GGally","ggplot2","ggpubr","ggrepel","gplots","grid","klaR","MASS",
#              "polycor","psych","reshape2","RKEEL","scales","SDEFSR","tidyverse")

ipak(packages) #Instalo o cargo

update.packages()


#help(tidyverse)
#??caret
#help(RSNNS)
#help(frbs)
#??FSinR
#help(fable)


# Generamos datos de ejemplo
data <- tibble(
  x = c(1:100)*1.0,
  y = 0.5*x + rnorm(100, mean = 0, sd = 5)
)

# Graficamos los datos y la línea ajustada por el modelo
data %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Modelo lineal ajustado")

fit <- caret::train(y ~ x, data = data, method = "lm")

model <- mlp(data[1:5,1:2],data[1:5,2], size=5, learnFuncParams = c(0.1))

fitted_model <- predict(model, data)
#?frbs.learn

data.train <- matrix(c(5.2, -8.1, 4.8, 8.8, -16.1, 4.1, 10.6, -7.8, 5.5, 10.4, -29.0, 
                       5.0, 1.8, -19.2, 3.4, 12.7, -18.9, 3.4, 15.6, -10.6, 4.9, 1.9, 
                       -25.0, 3.7, 2.2, -3.1, 3.9, 4.8, -7.8, 4.5, 7.9, -13.9, 4.8, 
                       5.2, -4.5, 4.9, 0.9, -11.6, 3.0, 11.8, -2.1, 4.6, 7.9, -2.0, 
                       4.8, 11.5, -9.0, 5.5, 10.6, -11.2, 4.5, 11.1, -6.1, 4.7, 12.8, 
                       -1.0, 6.6, 11.3, -3.6, 5.1, 1.0, -8.2, 3.9, 14.5, -0.5, 5.7, 
                       11.9, -2.0, 5.1, 8.1, -1.6, 5.2, 15.5, -0.7, 4.9, 12.4, -0.8, 
                       5.2, 11.1, -16.8, 5.1, 5.1, -5.1, 4.6, 4.8, -9.5, 3.9, 13.2, 
                       -0.7, 6.0, 9.9, -3.3, 4.9, 12.5, -13.6, 4.1, 8.9, -10.0, 
                       4.9, 10.8, -13.5, 5.1), ncol = 3, byrow = TRUE)

frbs_obj <- frbs.learn(data.train)
#?frbs::predict
newdata <- matrix(c(10.5, -0.9, 5.8, -2.8, 8.5, -0.2, 13.8, -11.9, 9.8, -1.2, 11.0,
                    -14.3, 4.2, -17.0, 6.9, -3.3, 13.2, -1.9), ncol = 2, byrow = TRUE)
predict(frbs_obj, newdata)

# Utilizamos el paquete fable para hacer una predicción de los próximos 5 valores
fc <- data %>% 
  as_tsibble(index = x) %>%
  model(ARIMA = ARIMA(y)) %>%
  forecast(h = 5)

# Graficamos los datos y las predicciones
#autoplot(data = data, index = data$x, level = NULL) +
#  autolayer(fc, series = "Point Forecast") +
#   labs(title = "Predicciones de ARIMA")

# Imprime un mensaje de éxito si todo funciona correctamente
cat("¡Todos los paquetes funcionan correctamente!\n")
