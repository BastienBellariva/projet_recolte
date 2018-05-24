#!/bin/bash

#A decommenter si la distrib linux n'est pas a jour
#apt-get update && apt-get upgrade -y
#echo "Mise à jour packages système done"


echo "Veuillez saisir le nom d'utilisateur de la BDD"
read -r USER

echo -n "Votre mot de passe : "
trap "stty echo" EXIT HUP INT QUIT
stty -echo
read -r PASS
stty echo
trap - EXIT HUP INT QUIT



#Lancement du script "1_creation_base" : crée la base d_vigne
mysql --user=${USER} --password=${PASS} <../sql/1_creation_base.sql
if [ $? -eq 0 ]; then
    echo "La création de la base de données est terminée." 
else
echo "[Error] Création de la base de données"
fi

#Lancement du script "2_import_vigne" : importe toutes les valeurs avec le numéro de département faisant l'unicité des lignes
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/2_import_vigne.sql
if [ $? -eq 0 ]; then
    echo "L'import de l'ensemble des valeurs s'est déroulé correctement." 
else
echo "[Error] Import de l'ensemble des valeurs"
fi

#Lancement du script "3_import_cepage" : importe toutes les cepages de vin
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/3_import_cepage.sql
if [ $? -eq 0 ]; then
    echo "La table cepage a été créée et ses valeurs importées correctement." 1>&2
else
echo "[Error] Création et importation table cepage"
fi

#Lancement du script "4_import_departement" : importe tous les départements
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/4_import_departement.sql
if [ $? -eq 0 ]; then
    echo "La table departement a été créée et ses valeurs importées correctement." 1>&2
else
echo "[Error] Création et importation table departement"
fi

#Lancement du script "5_import_categorie" : importe tous les categories
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/5_import_categorie.sql
if [ $? -eq 0 ]; then
    echo "La table categorie a été créée et ses valeurs importées correctement." 1>&2
else
echo "[Error] Création et importation table categorie"
fi

#Lancement du script "6_creation_autres_tables" : créer les autres tables donc l'ensemble de la base de données.
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/6_creation_autres_tables.sql
if [ $? -eq 0 ]; then
    echo "Les tables de la base d_vigne ont bien été créées." 1>&2
else
echo "[Error] Création des tables de la base d_vigne"
fi 

#Lancement du script "7_remplissage_surface" : remplie la table t_surface
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/7_remplissage_surface.sql
if [ $? -eq 0 ]; then
    echo "La table surface a été remplie avec succès." 1>&2
else
echo "[Error] Remplissage table surface"
fi

#Lancement du script "8_remplissage_quantite" : remplie la table t_quantite
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/8_remplissage_quantite.sql
if [ $? -eq 0 ]; then
    echo "La table quantite a été remplie avec succès." 1>&2
else
echo "[Error] Remplissage table quantite"
fi

#Lancement du script "9_remplissage_surface_detail" : remplie la table t_surface_detail
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/9_remplissage_surface_detail.sql
if [ $? -eq 0 ]; then
    echo "La table surface detail a été remplie avec succès." 1>&2
else
echo "[Error] Remplissage table surface detail"
fi

#Lancement du script "10_remplissage_quantite_detail" : remplie la table t_quantite_detail
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/10_remplissage_quantite_detail.sql
if [ $? -eq 0 ]; then
    echo "La table quantite detail a été remplie avec succès." 1>&2
else
echo "[Error] Remplissage table quantite detail"
fi

#Lancement du script "11_import_appellation" : remplie la table t_appellation et gère les jonctions avec les départements
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/11_import_appellation.sql
if [ $? -eq 0 ]; then
    echo "La table appellation a été remplie avec succès et les liens avec les départements sont fonctionnels." 1>&2
else
echo "[Error] Remplissage table appellation"
fi

#Lancement du script "12_import_region" : remplie la table t_region et met à jour la table departement
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/12_import_region.sql
if [ $? -eq 0 ]; then
    echo "La table t_region a été remplie avec succès et la table t_département est à jour. Le lien département-region est opérationnel." 1>&2
else
echo "[Error] Remplissage table region / MAJ table departement"
fi

#Lancement du script "13_import_cepage_appellation" : remplie la table t_cepage_appelation
mysql --user=${USER} --password=${PASS} d_vigne < ../sql/13_import_cepage_appellation.sql
if [ $? -eq 0 ]; then
    echo "La table t_cepage_appellation a été remplie avec succès. Le lien cepage-appellation est opérationnel." 1>&2
else
echo "[Error] Remplissage table t_cepage_appellation"
fi