## Centre de yoga Sanadora - Analyse statistique 🧘‍♀️🌱

### Présentation du Centre de yoga Sanadora 🧘‍♀️🌱

Le Centre de yoga Sanadora, situé au centre-ville de Saint-Hyacinthe, est un espace de bien-être à dimension humaine qui adopte une approche holistique, combinant le travail du corps et de l’esprit dans un environnement calme, intime et accessible.

Fondé en 2024 par Mylène et Frédérike, le centre se distingue par une ambiance chaleureuse, inclusive et sans jugement. Les cours, offerts en petits groupes, favorisent un accompagnement personnalisé permettant aux participants de ralentir et de se reconnecter à eux-mêmes.

Au-delà du yoga, Sanadora propose une offre diversifiée de services axés sur le mieux-être :

- Cours de yoga et de pilates

- Massothérapie

- Programmation neuro-linguistique (PNL)

- Services corporatifs (yoga, pilates, ateliers, massage sur chaise)

- Ateliers et expériences bien-être (retraites, méditation guidée, introspection)

Le Centre Sanadora se positionne ainsi comme un espace complet combinant activité physique douce, relaxation et développement personnel, favorisant un équilibre durable entre le corps et l’esprit.


 Pour plus d'information ➡️ [Centre Sanadora](https://sanadora.ca)

### Description du projet 🎯

Ce projet vise à ***analyser la fréquentation hebdomadaire par genre*** (Hommes VS Femmes) au centre Sanadora.
À partir de données collectées sur une période de 28 semaines, l'objectif est de déterminer s'il existe une différence signification entre les deux groupes. 

L'analyse a été réalisé à l'aide du langage R et repose principalement sur une ANOVA en blocs aléatoires complets.

### Hypothèses 🔍

## Hypothèses

| Hypothèse | Description |
|-----------|-------------|
| Statistique (H₀) | Autant d'hommes que de femmes fréquentent le centre Sanadora (μ_hommes = μ_femmes) |
| Scientifique (H₁) | Plus de femmes que d'hommes fréquentent le centre Sanadora (μ_femmes > μ_hommes) |

### Structure du projet 🏗️
```

Centre_Sanadora/
|_ README.md                    # Documentation principales
|_ Sanadora_Data.CSV            # Données brutes
|_ graphes /                    # Visualisation générées
|   |_ Diagramme_moustache.png
|   |_ Moyennes_des_racines.png
|   |_ Racine_carrée_des moyennes_des_présences.png
|   |_ Superposition_ANOVA.png
|_ .gitignore                   # Fichier exclus du dépôt 
```

## Méthodologie 📋

**Plan d'échantillonnage**

Échantillonnage systémique à partir du registre de présences : chaque semaine constitue un bloc d'observation.
La variable réponse est le nombre de présences hebdommadaires par genre. 

**Choix du test statistique- ANOVA en blocs complets aléatoires**

L'ANOVA (Analysis of variance) est une approche statistique qui compare les moyennes de plusieurs groupes entre eux pour déterminer si au moins un des groupes diffère des autres. 
Le scénario typique de l'ANOVA est celui d'une expérience visant à comparer l'effet d'une variable catégorique sur une variable réponse d'intérêt. 

Dans ce projet, la variable catégorique est le genre - Hommes /Femmes,
puis la variable réponse d'intérêt est le nombre de présences hebdomadaires. 

**Superpositions vérifiées**

- Indépendance des observations, si cette condition n'est pas respectée, la variabilité des données sera sous-estimée 

- Homoscédasticité, l'égalité de la variance des groupes

- Normalité des résidus, la supposition de chacun des groupes est issue d'une population normale 

**Transformation des données**

Une transformation carine carrée a été appliquée pour stabiliser la variance.

Cette transformation est recommandée lorsque les données sont sous forme de fréquences, la transformation peut homogénéiser les variances. 

### Technologies utilisées 🛠️

**Packages R :** ```tidyr``` Base R( ```aov``` , ```TukeyHSD``` , ```boxplot``` )

### Données 📊

Le fichier ```Sanadora_Data.csv```contient les présences pour 28 semaines de cours. 

### Résultats 📈

L'ANOVA en bloc aléatoires complets réalisée sur les données transformée met en évidence un effet hautement significatif du genre sur la fréquentation hebdomadaire du Centre Sanadora

#### Résultat de l'ANOVA 

|Source| Df | Sum Sq | Mean Sq | F value | Pr(>F)| Interprétation|
|------|----|--------|---------|---------|-------|---------------|
|Genre|1| 76.54| 76.54| 364.799 | 364.799 | <2e-16 ***| Différence très forte entre les genres|
|Semaine| 27| 15.95| 0.59| 2.816| 0.00454 **| Variabilité temporelle significative|
|Residuals| 27|5.67| 0.21|

Signif. codes :```0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 ```

#### Moyennes observées après la transformation racine carrée 

|Genre| Moyenne transformée|
|-----|--------------------|
|Femmes| 4.296873|
|Hommes| 1.958651|

Les femmes représentent une fréquentation hebdomadaire beaucoup plus élevé que les hommes, même après la stabilisation de la variable 

#### Résultat du test de Tukey - Comparaison multiple 

|Comparaison | diff | lwr |upr p | adj|
|------------|------|-----|------|----|
|Hommes-Femmes| -2.338222|-2.589411 | -2.087033 | 0|

### Visualisation des données 📊

Plusieurs graphiques ont été générés afin d'explorer les données et illustrer les résultats statistiques.

#### Diagramme à moustache

Compare la distribution brute des présences entre hommes et femmes. 
Le graphique représente une différence marquée en faveur des femmes 

![Diagramme moustache](https://github.com/alepine9596/Centre-Sanadora/raw/main/graphes/Diagramme%20moustache.png)
<img src="https://github.com/alepine9596/Centre-Sanadora/raw/main/graphes/Diagramme%20moustache.png" width="350">



*Projet réalisé dans le cadre du cours SCI1018 - Statisques avec R, TÉLUQ*

*Réalisé par Alexandra Lépine* 

