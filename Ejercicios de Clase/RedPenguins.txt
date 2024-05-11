# Carga de paquetes
library(tidyverse)
library(caret)
library(neuralnet)
library(ggplot2)

# Preprocesamiento de datos
datos <- penguins
datos <- datos[complete.cases(datos), ]  # Eliminamos filas con valores faltantes
muestra <- createDataPartition(datos$species, p = 0.8, list = FALSE)
train <- datos[muestra, ]
test <- datos[-muestra, ]

# Escalado de datos
train_scaled <- as.data.frame(scale(train[, c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")]))
train_scaled$species <- train$species
# Entrenamiento de la red neuronal con más capas ocultas
red.neuronal <- neuralnet(species ~ bill_length_mm + bill_depth_mm + flipper_length_mm + body_mass_g,
                          data = train_scaled,
                          hidden = c(5, 4, 3)) # Aumenta el número de nodos en las capas ocultas

# Graficación de la red neuronal
plot(red.neuronal)
