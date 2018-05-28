-- affiche tout le recap
SELECT CONCAT(numero_departement, ' ', libelle_departement) AS Departement, 
CONCAT(numero_region, ' ', libelle_region) AS Region, 
total_surface AS 'Superficie totale (ha)',
aop.valeur_surface_detail AS 'AOP (ha)',
aca.valeur_surface_detail AS 'ACA (ha)',
igp.valeur_surface_detail AS 'IGP (ha)',
vsig.valeur_surface_detail AS 'VSIG (ha)',
aop_blanc.valeur_quantite_detail AS 'AOP blanc (hl)',
aop_rouge.valeur_quantite_detail AS 'AOP rouge (hl)',
aop_rose.valeur_quantite_detail AS 'AOP rose (hl)',
aop_vsi.valeur_quantite_detail AS 'AOP VSI/VCI (hl)',
igp_blanc.valeur_quantite_detail AS 'IGP blanc (hl)',
igp_rouge.valeur_quantite_detail AS 'IGP rouge (hl)',
igp_rose.valeur_quantite_detail AS 'IGP rose (hl)',
vsig_blanc.valeur_quantite_detail AS 'VSIG blanc (hl)',
vsig_rouge.valeur_quantite_detail AS 'VSIG rouge (hl)',
vsig_rose.valeur_quantite_detail AS 'VSIG rose (hl)',
aca_q.valeur_quantite_detail AS 'ACA (hl)',
quantite_commercialisable AS 'Production commercialisable (hl)',
quantite_non_commercialisable AS 'Production non commercialisable (hl)',
total_quantite AS 'Total (hl)'
FROM t_region r, 
t_departement d, 
t_surface s, 
(SELECT * FROM t_surface_detail WHERE id_categorie = 1) AS aop,
(SELECT * FROM t_surface_detail WHERE id_categorie = 2) AS aca,
(SELECT * FROM t_surface_detail WHERE id_categorie = 3) AS igp,
(SELECT * FROM t_surface_detail WHERE id_categorie = 4) AS vsig,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 1 AND id_type = 2) AS aop_blanc,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 1 AND id_type = 1) AS aop_rouge,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 1 AND id_type = 3) AS aop_rose,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 1 AND id_type = 4) AS aop_vsi,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 3 AND id_type = 2) AS igp_blanc,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 3 AND id_type = 1) AS igp_rouge,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 3 AND id_type = 3) AS igp_rose,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 4 AND id_type = 2) AS vsig_blanc,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 4 AND id_type = 1) AS vsig_rouge,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 4 AND id_type = 3) AS vsig_rose,
(SELECT * FROM t_quantite_detail WHERE id_categorie = 2) AS aca_q,
t_quantite q
WHERE d.id_region = r.id_region
AND s.id_departement = d.id_departement
AND s.id_surface = aop.id_surface
AND s.id_surface = aca.id_surface
AND s.id_surface = igp.id_surface
AND s.id_surface = vsig.id_surface
AND q.id_quantite = aop_blanc.id_quantite
AND q.id_quantite = aop_rouge.id_quantite
AND q.id_quantite = aop_rose.id_quantite
AND q.id_quantite = aop_vsi.id_quantite
AND q.id_quantite = igp_blanc.id_quantite
AND q.id_quantite = igp_rouge.id_quantite
AND q.id_quantite = igp_rose.id_quantite
AND q.id_quantite = vsig_blanc.id_quantite
AND q.id_quantite = vsig_rouge.id_quantite
AND q.id_quantite = vsig_rose.id_quantite
AND q.id_quantite = aca_q.id_quantite
AND d.id_departement = q.id_departement
ORDER BY Departement
;
