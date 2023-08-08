-- publ.corpus_mesh_title source

CREATE MATERIALIZED VIEW publ.corpus_mesh_title
TABLESPACE pg_default
AS SELECT m.dbrecordid,
    h.id,
    h.term AS mesh_term_title
   FROM ( SELECT "corpus_keywords_MeSH".dbrecordid,
            unnest("corpus_keywords_MeSH"."MeSH_ID_title") AS idtit,
            unnest("corpus_keywords_MeSH"."MeSH_title") AS termtit
           FROM ke_stage."corpus_keywords_MeSH") m
     JOIN publ.mesh_mainheadings h ON m.idtit::text = h.id
WITH DATA;