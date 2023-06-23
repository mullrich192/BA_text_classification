-- publ.corpus_agrovoc_abs source

CREATE MATERIALIZED VIEW publ.corpus_agrovoc_abs
TABLESPACE pg_default
AS SELECT m.dbrecordid,
    h.id,
    h.term AS agro_term_abs
   FROM ( SELECT "corpus_keywords_AGROVOC".dbrecordid,
            unnest("corpus_keywords_AGROVOC"."AGROVOC_ID_abs") AS idabs,
            unnest("corpus_keywords_AGROVOC"."AGROVOC_abs") AS termabs
           FROM ke_stage."corpus_keywords_AGROVOC") m
     JOIN publ.agrovoc_mainheadings h ON m.idabs::text = h.id::text
WITH DATA;