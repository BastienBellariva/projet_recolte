-- Table surface : stocke la surface totale d'un département et permet le lien avec les surfaces détaillées par categorie de vin
CREATE TABLE t_surface (
  id_surface INT(4) NOT NULL AUTO_INCREMENT,
  total_surface FLOAT(10) NOT NULL,
  id_departement INT(4) NOT NULL,
  CONSTRAINT pk_id_surface PRIMARY KEY(id_surface),
    CONSTRAINT fk_surface_departement FOREIGN KEY(id_departement) REFERENCES t_departement(id_departement)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table quantité : stocke la quantité totale d'un département et permet le lien avec les quantités détaillées par categorie/type de vin
CREATE TABLE t_quantite (
  id_quantite INT(4) NOT NULL AUTO_INCREMENT,
  total_quantite FLOAT(4) NOT NULL,
  quantite_commercialisable FLOAT(4) NOT NULL,
  quantite_non_commercialisable FLOAT(4) NOT NULL,
  id_departement INT(4) NOT NULL,
  CONSTRAINT pk_id_quantite PRIMARY KEY(id_quantite),
    CONSTRAINT fk_quantite_departement FOREIGN KEY(id_departement) REFERENCES t_departement(id_departement)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table surface détaillée : stocke les surfaces détaillés directement en lien avec le categorie de vin
CREATE TABLE t_surface_detail (
  id_surface_detail INT(4) NOT NULL AUTO_INCREMENT,
  id_categorie INT(4) NOT NULL,
  id_surface INT(4) NOT NULL,
  valeur_surface_detail FLOAT(4) NOT NULL,
  CONSTRAINT pk_id_surface_detail PRIMARY KEY(id_surface_detail),
    CONSTRAINT fk_surface_detail_categorie FOREIGN KEY(id_categorie) REFERENCES t_categorie(id_categorie),
    CONSTRAINT fk_surface_detail_surface FOREIGN KEY(id_surface) REFERENCES t_surface(id_surface)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table quantité détaillée : stocke les quantités détaillés directement en lien avec le categorie et le type de vin
CREATE TABLE t_quantite_detail (
  id_quantite_detail INT(4) NOT NULL AUTO_INCREMENT,
  id_categorie INT(4) NOT NULL,
  id_quantite INT(4) NOT NULL,
  id_type INT(4) NOT NULL,
  valeur_quantite_detail FLOAT(4) NOT NULL,
  CONSTRAINT pk_id_quantite_detail PRIMARY KEY(id_quantite_detail),
    CONSTRAINT fk_quantite_detail_categorie FOREIGN KEY(id_categorie) REFERENCES t_categorie(id_categorie),
    CONSTRAINT fk_quantite_detail_quantite FOREIGN KEY(id_quantite) REFERENCES t_quantite(id_quantite),
    CONSTRAINT fk_quantite_detail_type FOREIGN KEY(id_type) REFERENCES t_type(id_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table déclaration : stocke le nombre de déclarations de récoltes par département
CRATE TABLE t_declaration_recolte (
  id_declaration_recolte INT(4) NOT NULL AUTO_INCREMENT,
  nombre_declaration recolte INT(4) NOT NULL,
  id_departement INT(4) NOT NULL,
  CONSTRAINT pk_id_declaration_recolte PRIMARY KEY(id_declaration_recolte),
    CONSTRAINT fk_declaration_recolte_departement FOREIGN KEY(id_departement) REFERENCES t_departement(id_departement)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;