-- affiche superficie et pourcentage des superficie par type de vin et par departement
SELECT CONCAT(numero_departement, ' ', libelle_departement) AS Departement,
total_surface AS 'Superficie totale (ha)',
aop.valeur_surface_detail AS 'AOP (ha)',
aca.valeur_surface_detail AS 'ACA (ha)',
igp.valeur_surface_detail AS 'IGP (ha)',
vsig.valeur_surface_detail AS 'VSIG (ha)',
CONCAT(TRUNCATE(aop.valeur_surface_detail/total_surface * 100, 1), ' %') AS 'Pourcentage d''AOP',
CONCAT(TRUNCATE(aca.valeur_surface_detail/total_surface * 100, 1), ' %') AS 'Pourcentage d''ACA',
CONCAT(TRUNCATE(igp.valeur_surface_detail/total_surface * 100, 1), ' %') AS 'Pourcentage d''IGP',
CONCAT(TRUNCATE(vsig.valeur_surface_detail/total_surface * 100, 1), ' %') AS 'Pourcentage de VSIG'
FROM t_departement d, 
t_surface s, 
(SELECT * FROM t_surface_detail WHERE id_categorie = 1) AS aop,
(SELECT * FROM t_surface_detail WHERE id_categorie = 2) AS aca,
(SELECT * FROM t_surface_detail WHERE id_categorie = 3) AS igp,
(SELECT * FROM t_surface_detail WHERE id_categorie = 4) AS vsig
WHERE s.id_departement = d.id_departement
AND s.id_surface = aop.id_surface
AND s.id_surface = aca.id_surface
AND s.id_surface = igp.id_surface
AND s.id_surface = vsig.id_surface
ORDER BY Departement
;