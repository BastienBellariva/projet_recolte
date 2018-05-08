SELECT e.libelle_etablissement, s.libelle_secteur, t.libelle_type 
FROM etablissement e, secteur s, type t
WHERE e.secteur_etablissement = s.id_secteur
AND e.type_etablissement = t.id_type
AND e.libelle_etablissement = 'Campus Condorcet';

SELECT e.libelle_etablissement, s.libelle_secteur, t.libelle_type 
FROM etablissement e, secteur s, type t
WHERE e.secteur_etablissement = s.id_secteur
AND e.type_etablissement = t.id_type
AND e.libelle_etablissement = 'Skema Business School';
