-- ke_stage.corpus_keywords source

CREATE MATERIALIZED VIEW ke_stage.corpus_keywords
TABLESPACE pg_default
AS WITH agro_title AS (
         SELECT corpus_agrovoc_title.dbrecordid AS id1,
            array_agg(corpus_agrovoc_title.agro_term_title) AS agro_title
           FROM publ.corpus_agrovoc_title
          GROUP BY corpus_agrovoc_title.dbrecordid
        ), agro_abs AS (
         SELECT corpus_agrovoc_abs.dbrecordid AS id2,
            array_agg(corpus_agrovoc_abs.agro_term_abs) AS agro_abs
           FROM publ.corpus_agrovoc_abs
          GROUP BY corpus_agrovoc_abs.dbrecordid
        ), mesh_title AS (
         SELECT corpus_mesh_title.dbrecordid AS id3,
            array_agg(corpus_mesh_title.mesh_term_title) AS mesh_title
           FROM publ.corpus_mesh_title
          GROUP BY corpus_mesh_title.dbrecordid
        ), mesh_abs AS (
         SELECT corpus_mesh_abs.dbrecordid AS id4,
            array_agg(corpus_mesh_abs.mesh_term_abs) AS mesh_abs
           FROM publ.corpus_mesh_abs
          GROUP BY corpus_mesh_abs.dbrecordid
        ), agro_total AS (
         SELECT a.id1,
            a.agro_title,
            b.id2,
            b.agro_abs
           FROM agro_title a
             FULL JOIN agro_abs b ON a.id1::text = b.id2::text
        ), mesh_total AS (
         SELECT c.id3,
            c.mesh_title,
            d.id4,
            d.mesh_abs
           FROM mesh_title c
             FULL JOIN mesh_abs d ON c.id3::text = d.id4::text
        )
 SELECT agro_total.id1,
    agro_total.agro_title,
    agro_total.id2,
    agro_total.agro_abs,
    mesh_total.id3,
    mesh_total.mesh_title,
    mesh_total.id4,
    mesh_total.mesh_abs
   FROM agro_total
     FULL JOIN mesh_total ON agro_total.id1::text = mesh_total.id3::text
WITH DATA;