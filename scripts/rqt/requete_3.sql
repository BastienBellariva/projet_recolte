-- affiche quantite de vins par cepage et pourcentage
SELECT CONCAT(numero_departement, ' ', libelle_departement) AS Departement,
total_quantite AS 'Production total (hl)',
TRUNCATE(blanc.valeur_quantite_detail, 0) AS 'Blanc (hl)',
TRUNCATE(rouge.valeur_quantite_detail, 0) AS 'Rouge (hl)',
TRUNCATE(rose.valeur_quantite_detail, 0) AS 'Rose (hl)',
TRUNCATE(vsi.valeur_quantite_detail, 0) AS 'VSI (hl)',
TRUNCATE(aca.valeur_quantite_detail, 0) AS 'ACA (hl)',
CONCAT(TRUNCATE(TRUNCATE(blanc.valeur_quantite_detail, 0)/total_quantite * 100, 1), ' %') AS 'Pourcentage de blanc',
CONCAT(TRUNCATE(TRUNCATE(rouge.valeur_quantite_detail, 0)/total_quantite * 100, 1), ' %') AS 'Pourcentage de rouge',
CONCAT(TRUNCATE(TRUNCATE(rose.valeur_quantite_detail, 0)/total_quantite * 100, 1), ' %') AS 'Pourcentage de rose',
CONCAT(TRUNCATE(TRUNCATE(vsi.valeur_quantite_detail, 0)/total_quantite * 100, 1), ' %') AS 'Pourcentage de VSI',
CONCAT(TRUNCATE(TRUNCATE(aca.valeur_quantite_detail, 0)/total_quantite * 100, 1), ' %') AS 'Pourcentage d''ACA'
FROM t_departement d, 
t_quantite q,
(SELECT id_quantite, SUM(valeur_quantite_detail) AS 'valeur_quantite_detail' FROM t_quantite_detail WHERE id_cepage = 2 GROUP BY id_cepage , id_quantite) AS blanc,
(SELECT id_quantite, SUM(valeur_quantite_detail) AS 'valeur_quantite_detail' FROM t_quantite_detail WHERE id_cepage = 1 GROUP BY id_cepage , id_quantite) AS rouge,
(SELECT id_quantite, SUM(valeur_quantite_detail) AS 'valeur_quantite_detail' FROM t_quantite_detail WHERE id_cepage = 3 GROUP BY id_cepage , id_quantite) AS rose,
(SELECT id_quantite, SUM(valeur_quantite_detail) AS 'valeur_quantite_detail' FROM t_quantite_detail WHERE id_cepage = 4 GROUP BY id_cepage , id_quantite) AS vsi,
(SELECT id_quantite, SUM(valeur_quantite_detail) AS 'valeur_quantite_detail' FROM t_quantite_detail WHERE id_cepage = 9 GROUP BY id_cepage , id_quantite) AS aca
WHERE d.id_departement = q.id_departement
AND q.id_quantite = blanc.id_quantite
AND q.id_quantite = rouge.id_quantite
AND q.id_quantite = rose.id_quantite
AND q.id_quantite = vsi.id_quantite
AND q.id_quantite = aca.id_quantite
ORDER BY Departement
;