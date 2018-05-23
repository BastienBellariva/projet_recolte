#!/bin/bash

#A decommenter si la distrib linux n'est pas a jour
#apt-get update && apt-get upgrade -y
#echo "Mise à jour packages système done"

#Lancement du script "1_creation_base" : crée la base d_vigne
mysql -u root -p <../sql/1_creation_base.sql
echo "La création de la base de données est terminée."

#Lancement du script "2_import_vigne" : importe toutes les valeurs avec le numéro de département faisant l'unicité des lignes
mysql -u root -p d_vigne < ../sql/2_import_vigne.sql
echo "L'import de l'ensemble des valeurs s'est déroulé correctement."

#Lancement du script "3_import_cepage" : importe toutes les cepages de vin
mysql -u root -p d_vigne < ../sql/3_import_cepage.sql
echo "La table cepage a été créée et ses valeurs importées correctement."

#Lancement du script "4_import_departement" : importe tous les départements
mysql -u root -p d_vigne < ../sql/4_import_departement.sql
echo "La table departement a été créée et ses valeurs importées correctement."

#Lancement du script "5_import_categorie" : importe tous les categories
mysql -u root -p d_vigne < ../sql/5_import_categorie.sql
echo "La table categorie a été créée et ses valeurs importées correctement."

#Lancement du script "6_creation_autres_tables" : créer les autres tables donc l'ensemble de la base de données.
mysql -u root -p d_vigne < ../sql/6_creation_autres_tables.sql
echo "Les tables de la base d_vigne ont bien été créées."

#Lancement du script "7_remplissage_surface" : remplie la table t_surface
mysql -u root -p d_vigne < ../sql/7_remplissage_surface.sql
echo "La table surface a été remplie avec succès."

#Lancement du script "8_remplissage_quantite" : remplie la table t_quantite
mysql -u root -p d_vigne < ../sql/8_remplissage_quantite.sql
echo "La table quantite a été remplie avec succès."

#Lancement du script "9_remplissage_surface_detail" : remplie la table t_surface_detail
mysql -u root -p d_vigne < ../sql/9_remplissage_surface_detail.sql
echo "La table surface detail a été remplie avec succès."

#Lancement du script "10_remplissage_quantite_detail" : remplie la table t_quantite_detail
mysql -u root -p d_vigne < ../sql/10_remplissage_quantite_detail.sql
echo "La table quantite detail a été remplie avec succès."

#Lancement du script "11_import_appellation" : remplie la table t_appellation et gère les jonctions avec les départements
mysql -u root -p d_vigne < ../sql/11_import_appellation.sql
echo "La table appellation a été remplie avec succès et les liens avec les départements sont fonctionnels."

#Lancement du script "12_import_region" : remplie la table t_region et met à jour la table departement
mysql -u root -p d_vigne < ../sql/12_import_region.sql
echo "La table region a été remplie avec succès et la table département est à jour. Le lien département-region est opérationnel."

