# Analyse territoriale multiscalaire [<img src="https://rzine.fr/img/Rzine_logo.png"  align="right" width="120"/>](http://rzine.fr/)
### Application à la concentration de l’emploi dans la Métropole du Grand Paris
**Ronan Ysebaert (UMS RIATE, Univ. de Paris) et Claude Grasland (FR CIST, UMR Géographie-cités, Univ. de Paris)**
<br/>  

Cette fiche présente une **analyse territoriale multiscalaire** menée sur la **concentration de l'emploi** dans les communes de la **métropole du Grand Paris** (MGP). Cette analyse reproductible utilise des données de l'INSEE librement accessibles et montre l'usage et l'intérêt des fonctions du package `MTA` (**Multiscalar Territorial Analysis**) pour révéler l'existence d'inégalités territoriales dans un contexte multiscalaire.

Pour la consulter, cliquez [**ici**](https://rzine.fr/docs/20211101_ysebaert_grasland_MTA/index.html)


<br/>  

[![DOI:10.48645/hjvq-yp94](https://zenodo.org/badge/DOI/10.48645/hjvq-yp94.svg)](https://doi.org/10.48645/hjvq-yp94)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-sa/4.0/)

<br/>  


## Review - Gestion des modifications

Cette fiche a fait l'objet d'une relecture par Grégoire Le Campion (UMR 5319 Passages) le 27 Avril 2020. Trois issues ont guidé à son amélioration:

| **Issues**                                                                       | **Suivi des modifications**                                                                                                                                                                                                                                                               |
|----------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Synthèse générale](https://github.com/rzine-reviews/MTA/issues/1)               | La remarque n'induit pas de modifications. Le modèle de document a néanmoins été adapté au template rzine.                                                                                                                                                                                |
| [Réflexions générales](https://github.com/rzine-reviews/MTA/issues/2)            | - Temps de lecture ajouté (package `wordcountaddin`).<br>- Glossaire ajouté. <br>- Accessibilité du document précisée (introduction).<br>- Mise en fonction du modèle cartographique et de la mise en page des tableaux pour faciliter la lecture.<br>- Des tournures de phrase allégées. |
| [Réflexions code](https://github.com/rzine-reviews/MTA/issues/3#issue-868710097) | - Tout le code utile à la visualisation des résultats (statistiques, graphiques, cartographiques, tableaux) est dorénavant visible (chunk, echo = TRUE).<br>- Le problème d'affichage du boxplot était lié au fait que certains éléments de code n'étaient pas visibles.                  |

Par ailleurs, l'ensemble des fonctions de cartographie mobilisées utilisent dorénavant le package `mapsf`, qui a vocation à se substituer au package `cartography` (précédemment utilisé).
