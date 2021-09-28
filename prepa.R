###############################################################################
#                             RZINE MTA                                       #
#                    Préparation des données                                  # 
#                   R. YSEBAERT, 2021, RIATE                                  # 
###############################################################################



# Objectifs :
# Ne sélectionner que les IRIS/communes des métropoles, les enrichir par des données socio-économiques
# Créer un geopackage allégé directement utilisable dans la fiche rzine. 


# Déroulé
# 1 - Importe les données de référence de l'INSEE et IGN
# 2 - Extraction des IRIS appartenant à une des 22 métropoles françaises. 
# 3. Fusionne par commune, EPCI, métropole puis exportés au format geopackage. 
# 4. Enrichit les données avec des données attributaires
# 5 Ce geopackage contient quatre couches géographiques : celle des IRIS, celle des communes, celles des EPCI intermédiaires, et celles des métropoles. C'est le fichier utilisé par la fiche Rzine. 

# NB - On présuppose que les données d'entrées sont accessibles dans un dossier dénommé "input". 


################################################################################
#  1 - Import des données
################################################################################

# Librairies utiles 
library(mapsf)
library(readxl)

# Import des géométries IRIS (version 2019-01-01)
# Accessible ici :https://geoservices.ign.fr/contoursiris
iris <- st_read("input/CONTOURS-IRIS.shp", quiet = TRUE)

# Import de la table d'appartenance commune - métropole + libellés (version 2019-01-01)
# Accessible ici : https://www.insee.fr/fr/information/2028028
tmp1 <- as.data.frame(read_xls("input/table-appartenance-geo-communes-19.xls", 
                               col_types = "text", sheet = "COM", skip = 5))
tmp2 <- as.data.frame(read_xls("input/table-appartenance-geo-communes-19.xls", 
                               col_types = "text", sheet = "ARM", skip = 5))
tmp3 <- as.data.frame(read_xls("input/table-appartenance-geo-communes-19.xls", 
                               col_types = "text", skip = 5,
                               sheet = "Zones_supra_communales"))

# Combiner ces trois dataframes d'entrée (communes, arrondissement, zones supra-communales)
colnames(tmp3)[3] <- "LIB_EPCI"
metro <- rbind(tmp1, tmp2[, names(tmp1)])
metro <- merge(metro, tmp3[,c("CODGEO","LIB_EPCI")], by.x = "EPCI", by.y = "CODGEO",
               all.x = TRUE)


###############################################################################
# 2 - Filtre et enrichissement des métropoles (EPCI d'appartenance)
###############################################################################

# Sélection de toutes les communes appartenant à une métropole
metro <- metro[metro$NATURE_EPCI == "ME",]

# Import des EPCI constitutifs des métropoles (s'ils existent ou ont existé)
# Table organisée par nos soins, accessible ici : https://github.com/rysebaert/mta_rzine/tree/main/data
epci <- as.data.frame(read_xlsx("input/metropoles.xlsx", col_types = "text",
                                sheet = "metro"))

# Jointure IRIS - métropoles
iris <- merge(iris, metro[,c("CODGEO","EPCI","LIB_EPCI")],
              by.x = "INSEE_COM", by.y = "CODGEO", all.y = TRUE)

# Jointure IRIS - EPCI constitutifs
iris <- merge(iris, epci[,c("INSEE_COM", "EPCI_SUB", "LIB_EPCI_SUB")], 
              by = "INSEE_COM", all.x = TRUE)


###############################################################################
# 3 - Agrégation spatiales
###############################################################################

# Communes
com <- aggregate(x = iris[,c("NOM_COM", "EPCI", "LIB_EPCI", "EPCI_SUB", "LIB_EPCI_SUB")], 
                 by = list(INSEE_COM = iris$INSEE_COM),
                 FUN = head, 1)

# EPCI
epci <- aggregate(x = com[,c("EPCI", "LIB_EPCI", "EPCI_SUB")], 
                  by = list(LIB_EPCI_SUB = com$LIB_EPCI_SUB),
                  FUN = head, 1)

# Métropole
metro <- aggregate(x = com[,c("EPCI", "LIB_EPCI")], 
                   by = list(LIB_EPCI_SUB = com$LIB_EPCI),
                   FUN = head, 1)

# Communes : retirer Lyon, Marseille et Paris (arrondissements dispo)
com <- com[!com$INSEE_COM %in% c("75056", "69123", "13055"),]
iris <- iris[!iris$INSEE_COM %in% c("75056", "69123", "13055"),]


##########################################################################
# 4 - Données attributaires
##########################################################################

# Emploi localisé au lieu de travail [Communes]
# Source : https://www.insee.fr/fr/statistiques/4171446?sommaire=4171473 
tmp1 <- as.data.frame(read_xls("input/base-cc-emploi-pop-active-2016.xls", 
                               sheet = "COM_2016", skip = 5))
tmp2 <- as.data.frame(read_xls("input/base-cc-emploi-pop-active-2016.xls", 
                               sheet = "ARM_2016", skip = 5))

# Combiner communes et arrondissements
df <- rbind(tmp1, tmp2)

# Extraction des indicateurs d'intérêt
df <- df[,c("CODGEO", "P16_EMPLT","C16_ACTOCC1564")]

# Jointure avec les objets géographiques d'intérêt (appartenant à une métro)
com <- merge(com, df, by.x = "INSEE_COM", by.y = "CODGEO", all.x = TRUE)


# Motorisation des ménages [IRIS]
# Source : https://www.insee.fr/fr/statistiques/4228432
df <- as.data.frame(read_xls("input/base-ic-logement-2016.xls", sheet = "IRIS",
                             skip = 5))

# Extraction des indicateurs d'intérêt
df <- df[,c("IRIS", "P16_MEN", "P16_RP_VOIT1P")]

# Jointure avec les objets géographiques d'intérêt (appartenant à une métro)
iris <- merge(iris, df, by.x = "CODE_IRIS", by.y = "IRIS", all.x = TRUE)


##########################################################################
# 5 - Export des couches géographiques enrichies au format geopackage
##########################################################################

st_write(obj = iris, dsn = "data/data.gpkg", layer = "iris", 
         delete_layer = TRUE, quiet = TRUE)
st_write(obj = com, dsn = "data/data.gpkg", layer = "com", 
         delete_layer = TRUE, quiet = TRUE)
st_write(obj = epci, dsn = "data/data.gpkg", layer = "epci", 
         delete_layer = TRUE, quiet = TRUE)
st_write(obj = metro, dsn = "data/data.gpkg", layer = "metro", 
         delete_layer = TRUE, quiet = TRUE)