-- affiche les appellation et leurs departement
SELECT libelle_appellation AS 'Appellation',
description_appellation AS 'Description',
CONCAT(numero_departement, ' ', libelle_departement) AS Departement
FROM t_appellation a,
t_appellation_departement ad,
t_departement d
WHERE a.id_appellation = ad.id_appellation
AND ad.id_departement = d.id_departement
ORDER BY Appellation
;