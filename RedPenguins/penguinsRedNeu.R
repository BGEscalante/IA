#carga de paquetes
library(tidyverse)
library(caret)
library(neuralnet)

datos = penguins
datos = datos[complete.cases(datos), ]
muestra = createDataPartition(datos$species, p=0.8, list=F)
train = datos[muestra,]
test = datos[-muestra,]
red.neuronal = neuralnet(species ~ bill_length_mm + bill_depth_mm + flipper_length_mm + body_mass_g , data = train, hidden = c(2,3))
red.neuronal$act.fct
#graficacion de la red neuronal 
plot(red.neuronal)
#aplicar el conjunto de prueba a la red para predecir la especie 
prediccion = predict(red.neuronal, test, type = "class")
#decodificar la columna que contiene el valor maximo 
# y por ende la especie de la que se trata
decodificarCol = apply(prediccion,1, which.max)
#crear una columna con los valores decodificados
codificado = data_frame(decodificarCol)
codificado = mutate(codificado, especie=recode(codificado$decodificarCol, "1" = "Adelie", "2" = "Chinstrap", "3" = "Gentoo"))
test$Especie.Pred = codificado$especie