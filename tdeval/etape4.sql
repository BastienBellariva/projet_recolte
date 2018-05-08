CREATE PROCEDURE afficher_universite()
SELECT e.libelle_etablissement, t.libelle_type FROM etablissement e, type t WHERE t.id_type = e.type_etablissement AND t.libelle_type = 'Université';

CALL afficher_universite();
