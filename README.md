# Analyse territoriale multiscalaire

## Auteurs et accès

Fiche méthodologique réalisée par Ronan Ysebaert (UMS RIATE, Université de Paris) et Claude Grasland (FR CIST, Université de Paris, UMR Géographie-cités)

-> [Consulter](https://rysebaert.github.io/mta_rzine/)


## Une publication rzine

Cette fiche a fait l'objet d'une soumission à la [collection Rzine](https://rzine.fr/collection).


## Review - Gestion des modifications

Cette fiche a fait l'objet d'une relecture par Grégoire Le Campion (UMR 5319 Passages) le 27 Avril 2020. Trois issues ont guidé à son amélioration:

| **Issues**                                                                       | **Suivi des modifications**                                                                                                                                                                                                                                                               |
|----------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Synthèse générale](https://github.com/rzine-reviews/MTA/issues/1)               | La remarque n'induit pas de modifications. Le modèle de document a néanmoins été adapté au template rzine.                                                                                                                                                                                |
| [Réflexions générales](https://github.com/rzine-reviews/MTA/issues/2)            | - Temps de lecture ajouté (package `wordcountaddin`).<br>- Glossaire ajouté. <br>- Accessibilité du document précisée (introduction).<br>- Mise en fonction du modèle cartographique et de la mise en page des tableaux pour faciliter la lecture.<br>- Des tournures de phrase allégées. |
| [Réflexions code](https://github.com/rzine-reviews/MTA/issues/3#issue-868710097) | - Tout le code utile à la visualisation des résultats (statistiques, graphiques, cartographiques, tableaux) est dorénavant visible (chunk, echo = TRUE).<br>- Le problème d'affichage du boxplot était lié au fait que certains éléments de code n'étaient pas visibles.                  |

Par ailleurs, l'ensemble des fonctions de cartographie mobilisées utilisent dorénavant le package `mapsf`, qui a vocation à se substituer au package `cartography` (précédemment utilisé).
