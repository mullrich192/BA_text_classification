-- publ.corpus_mesh_abs source

CREATE MATERIALIZED VIEW publ.corpus_mesh_abs
TABLESPACE pg_default
AS SELECT m.dbrecordid,
    h.id,
    h.term AS mesh_term_abs
   FROM ( SELECT "corpus_keywords_MeSH".dbrecordid,
            unnest("corpus_keywords_MeSH"."MeSH_ID_abs") AS idabs,
            unnest("corpus_keywords_MeSH"."MeSH_abs") AS termabs
           FROM ke_stage."corpus_keywords_MeSH") m
     JOIN publ.mesh_mainheadings h ON m.idabs::text = h.id
WITH DATA;