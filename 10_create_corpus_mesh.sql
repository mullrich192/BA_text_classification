-- publ.corpus_keywords_mesh source

CREATE MATERIALIZED VIEW publ.corpus_keywords_mesh
TABLESPACE pg_default
AS WITH mesh_title AS (
         SELECT corpus_mesh_title.dbrecordid AS id1,
            array_agg(corpus_mesh_title.mesh_term_title) AS mesh_title
           FROM publ.corpus_mesh_title
          GROUP BY corpus_mesh_title.dbrecordid
        ), mesh_abs AS (
         SELECT corpus_mesh_abs.dbrecordid AS id2,
            array_agg(corpus_mesh_abs.mesh_term_abs) AS mesh_abs
           FROM publ.corpus_mesh_abs
          GROUP BY corpus_mesh_abs.dbrecordid
        )
 SELECT c.id1,
    c.mesh_title,
    d.id2,
    d.mesh_abs
   FROM mesh_title c
     FULL JOIN mesh_abs d ON c.id1::text = d.id2::text
WITH DATA;