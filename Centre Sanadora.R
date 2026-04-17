##Configuration du chemin
setwd('/Users/alexandralepine/Centre Sanadora')

##Chargement des données
Sanadora <- read.csv("Sanadora_Data.csv", header = TRUE)

## Aperçu des données
head(Sanadora)
##Afficher la structure des données
str(Sanadora)

##Conversion des données en facteur
Sanadora$Semaine <- as.factor(Sanadora$Semaine)

##Afficher la structure des données suite à la conversion
str(Sanadora)

##Visualisation des données à partir d'un diagramme à moustache
boxplot( Sanadora$Hommes, Sanadora$Femmes,
         names = c ("Hommes", "Femmes"),
         main = "Présence hebdomadaire par genre au centre de yoga Sanadora",
         xlab = "Genre",
         ylab = "Présences",
         col = c ("blue", "pink"))

##Restructuration des données pour effectuer l'ANOVA en bloc aléatoire complet
library(tidyr)
Sanadora_Restruc <- pivot_longer(Sanadora, cols = c (Hommes, Femmes),
                                 names_to = "Genre",
                                 values_to = "Présence")
Sanadora_Restruc$Présence <- as.numeric(Sanadora_Restruc$Présence)

##Afficher les données suite à la restructuration
head(Sanadora_Restruc)

## Stabilisation de la variance - Transformation racine carrée
Sanadora_Restruc$Présence_sqrt <- sqrt(Sanadora_Restruc$Présence)

## ANOVA en bloc complets aléatoires
Sanadora_AOV <- aov (Présence_sqrt ~ Genre + Semaine, data = Sanadora_Restruc)

#Résultats
summary(Sanadora_AOV)

##Vérification des supposition de l'ANOVA
par(mfrow = c (2,2))
plot(Sanadora_AOV)
par(mfrow = c(1,1))

##Moyennes des groupes avant la transformation
Sanadora_means <-tapply(X = Sanadora_Restruc$Présence, INDEX = Sanadora_Restruc$Genre, FUN = mean)
Result_Sanadora_Means <- tapply(Sanadora_Restruc$Présence,
                                list(Sanadora_Restruc$Semaine, Sanadora_Restruc$Genre),
                                mean)

##Afficher le résultat
as.data.frame(Result_Sanadora_Means)


##Moyennes des groupes suite à la transformation
Result_Sanadora_means_sqrt <- tapply(Sanadora_Restruc$Présence_sqrt, Sanadora_Restruc$Genre, mean)
Result_Sanadora_means_sqrt

##Test de Tukey - Comparaisons multiples
TukeyHSD(Sanadora_AOV, which = "Genre")

##Représentation graphique

##Calcul des barres d'erreur
MSE       <- summary(Sanadora_AOV)[[1]]["Residuals", "Mean Sq"]
low.sqrt <- Result_Sanadora_means_sqrt - sqrt (MSE)
upp.sqrt <- Result_Sanadora_means_sqrt + sqrt (MSE)
low <- low.sqrt ^2
upp <- upp.sqrt ^2
Genre_x <- 1:2

## Graphique des moyennes transformées 
plot(Result_Sanadora_means_sqrt ~ Genre_x,
     ylab = "Racine carrée des présences",
     xlab= "Genre",
     type = "p",
     pch = 16,
     cex = 1.5,
     ylim = c(min(low.sqrt) - 0.1, max(upp.sqrt) + 0.1),
     xlim = c(0.5, 2.5),
     cex.lab = 1.2,
     xaxt = "n",
     main = "Racine carrée des moyennes des présence au centre Sanadora ")
axis(side = 1, at= 1:2, labels = c("Femmes", "Hommes"))

arrows(x0= Genre_x, x1= Genre_x,
       y0 = low.sqrt, y1= upp.sqrt,
       angle = 90, code = 3, length = 0.05)
text(x = 1, y = upp.sqrt[1] + 0.1, labels = "a", cex = 1.2)
text(x = 2, y = upp.sqrt [2] + 0.1, labels = "b", cex = 1.2)

## Graphique des moyennes non transformées 
  plot(Sanadora_means ~ Genre_x,
     ylab = "Nombre de présences",
     xlab = "Genre",
     type = "p",
     pch = 16,
     cex = 1.5,
     ylim = c(min(low) -1, max(upp) + 1),
     xlim = c(0.5, 2.5),
     cex.lab = 1.2,
     xaxt = "n",
     main = "Moyenne des présences au centre Sanadora")
axis(side = 1, at = 1:2, labels = c("Femmes", "Hommes"))

arrows(x0 = Genre_x, x1 = Genre_x,
       y0 = low, y1 = upp,
       angle = 90, code = 3, length = 0.05)
text (x = 1, y = upp[1] + 0.8, labels = "a", cex = 1.2)
text (x = 2, y = upp [2] + 0.8, labels = "b", cex = 1.2)

