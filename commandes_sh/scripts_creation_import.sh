#!/bin/bash

#A decommenter si la distrib linux n'est pas a jour
#apt-get update && apt-get upgrade -y
#echo "Mise à jour packages système done"

#Récupération du nom de la BDD a créer
#DBName = "$1"

#Lancement du script "1_creation_base" : crée la base d_vigne
mysql -u root -p <../scripts_SQL/1_creation_base.sql
echo "La création de la base de données est terminée."

#Lancement du script "2_import_recolte" : importe toutes les valeurs avec le numéro de département faisant l'unicité des lignes
mysql -u root -p d_vigne < ../scripts_SQL/2_import_recolte.sql
echo "L'import de l'ensemble des valeurs s'est déroulé correctement."

#Lancement du script "3_import_couleur" : importe toutes les couleurs de vin
mysql -u root -p d_vigne < ../scripts_SQL/3_import_couleur.sql
echo "La table couleur a été créée et ses valeurs importées correctement."

#Lancement du script "4_import_departement" : importe tous les départements
mysql -u root -p d_vigne < ../scripts_SQL/4_import_departement.sql
echo "La table departement a été créée et ses valeurs importées correctement."

#Lancement du script "5_import_type" : importe tous les types
mysql -u root -p d_vigne < ../scripts_SQL/5_import_type.sql
echo "La table type a été créée et ses valeurs importées correctement."

#Lancement du script "6_creation_autres_tables" : créer les autres tables donc l'ensemble de la base de données.
mysql -u root -p d_vigne < ../scripts_SQL/6_creation_autres_tables.sql
echo "Les tables de la base d_vigne ont bien été créées."

#Lancement du script "7_remplissage_surface" : remplie la table t_surface
mysql -u root -p d_vigne < ../scripts_SQL/7_remplissage_surface.sql
echo "La table surface a été remplie avec succès."

#Lancement du script "8_remplissage_quantite" : remplie la table t_quantite
#mysql -u root -p d_vigne < ../script_SQL/8_remplissage_quantite.sql
#echo "La table quantite a été remplie avec succès."

#Lancement du script "9_remplissage_surface_detail" : remplie la table t_surface_detail
#mysql -u root -p d_vigne < ../script_SQL/9_remplissage_surface_detail.sql
#echo "La table surface detail a été remplie avec succès."

#Lancement du script "10_remplissage_quantite_detail" : remplie la table t_quantite_detail
#mysql -u root -p d_vigne < ../script_SQL/10_remplissage_quantite_detail.sql
#echo "La table quantite detail a été remplie avec succès."


