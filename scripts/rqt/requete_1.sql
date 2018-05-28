-- affiche tous les departements et régions ainsi que leurs productions totales, superficie totales et production par hectare
SELECT CONCAT(numero_departement, ' ', libelle_departement) AS Departement, 
CONCAT(numero_region, ' ', libelle_region) AS Region,
total_surface AS 'Superficie totale des vignes (ha)',   
total_quantite AS 'Production total (hl)',
TRUNCATE(total_quantite/total_surface, 2) AS 'Prodcution par hectare (hl)'
FROM
t_region r,
t_departement d,
t_surface s,
t_quantite q
WHERE d.id_region = r.id_region
AND s.id_departement = d.id_departement
AND d.id_departement = q.id_departement
ORDER BY Departement
;