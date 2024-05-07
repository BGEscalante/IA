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

# Escalado de datos
train_scaled <- as.data.frame(scale(train[, c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")]))
train_scaled$species <- train$species

red.neuronal = neuralnet(species ~ bill_length_mm + bill_depth_mm + flipper_length_mm + body_mass_g, 
                         data = train_scaled, hidden = c(4,5,2))
#red.neuronal$act.fct
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

##Tamaño tux por specie
ggplot(data = penguins,
       aes(x = flipper_length_mm,
           y = body_mass_g)) + 
  geom_point(aes(color = species, 
                 shape = species),
                  size = 3,
                  alpha = 0.8) +
    #theme_minimal()+
    scale_color_manual(values = c("darkorange","purple", "cyan4")) +
    labs(title ="Tamaño del pinguino, Palmer Station LTER",
         subtitle = "Longitud de aleta y Masa corporal para pinguinos Adelie, Chinstrap y Gentoo",
         x = "Longitud de aleta (mm)",
         y = "Masa coroporal(g)",
         color = "especie de pinguino",
         shape = "especie de pinguino") + 
    theme_minimal()

##Tamaño tux por isla
ggplot(data = penguins,
       aes(x = flipper_length_mm,
           y = body_mass_g)) + 
  geom_point(aes(color = island, 
                 shape = species),
             size = 3,
             alpha = 0.8) +
  #theme_minimal()+
  scale_color_manual(values = c("darkorange","purple", "cyan4")) +
  labs(title ="Tamaño del pinguino, Palmer Station LTER",
       subtitle = "Longitud de aleta y Masa corporal segun cada isla",
       x = "Longitud de aleta (mm)",
       y = "Masa coroporal(g)",
       color = "isla del pinguino",
       shape = "especie de pinguino") + 
  theme_minimal()

##Tamaño tux por tam pico
ggplot(data = penguins,
       aes(x = flipper_length_mm,
           y = bill_length_mm)) + 
  geom_point(aes(color = species, 
                 shape = species),
             size = 3,
             alpha = 0.8) +
  #theme_minimal()+
  scale_color_manual(values = c("darkorange","purple", "cyan4")) +
  labs(title ="Tamaño del pinguino, Palmer Station LTER",
       subtitle = "Longitud de Aleta y longitud de pico segun tamaño del pinguino",
       x = "Longitud de aleta (mm)",
       y = "Tamaño de pico (mm)",
      color = "especie de pinguino",
       shape = "especie de pinguino") + 
  theme_minimal()

plot(red.neuronal)