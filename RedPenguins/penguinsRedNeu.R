#carga de paquetes
library(tidyverse)
library(caret)
library(neuralnet)
library(ggplot2)
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

datos %>%
  count(species)
datos%>%
  group_by(species)%>%
  summarize(across(where(is.numeric),mean,na.rm = TRUE))

plot(datos)

datos%>% 
  count(species) %>%
  ggplot() + geom_col(aes(x = species, y = n, fill = species)) 
  geom_label(aes(x = species, y =n, label= n )) + 
    scale_fill_manual(values = c('darkorange','purple', 'cyan4')) + 
    theme_minimal() + 
    labs(title = 'DISTRIBUCION DE PINGUINOS POR ESPECIE')
  
datos %>%
  drop() %>%
  count(sex,species) %>%
  ggplot() + geom_col(aes(x = species, y = n, fill= species)) +
  geom_label(aes(x=species, y=n, label = n)) +
  scale_fill_manual(values = c('darkorange','purple', 'cyan4')) +
  facet_wrap(~sex) +
  theme_minimal() +
  labs(title = 'Especies de pinguinos ~ sexo')