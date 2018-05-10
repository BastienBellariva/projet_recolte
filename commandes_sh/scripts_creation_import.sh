#!/bin/bash

#A decommenter si la distrib linux n'est pas a jour
#apt-get update && apt-get upgrade -y
#echo "Mise à jour packages système done"

#Récupération du nom de la BDD a créer
#DBName = "$1"

#Lancement du script "creation-base" : crée la base d_vigne
mysql -u root -p <../scripts_SQL/creation-base.sql

#Lancement du script "import_recolte" : importe toutes les valeurs avec le numéro de département faisant l'unicité des lignes
#mysql -u root -p d_vigne < ../scripts_SQL/import_recolte.sql

#Lancement du script "import_couleur" : importe toutes les couleurs de vin
#mysql -u root -p d_vigne < ../scripts_SQL/import_couleur.sql

#Lancement du script "import_departement" : importe tous les départements
#mysql -u root -p d_vigne < ../scripts_SQL/import_departement.sql

#Lancement du script "import_type" : importe tous les types
#mysql -u root -p d_vigne < ../scripts_SQL/import_type.sql

