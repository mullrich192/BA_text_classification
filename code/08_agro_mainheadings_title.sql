-- publ.corpus_agrovoc_title source

CREATE MATERIALIZED VIEW publ.corpus_agrovoc_title
TABLESPACE pg_default
AS SELECT m.dbrecordid,
    h.id,
    h.term AS agro_term_title
   FROM ( SELECT "corpus_keywords_AGROVOC".dbrecordid,
            unnest("corpus_keywords_AGROVOC"."AGROVOC_ID_title") AS idtit,
            unnest("corpus_keywords_AGROVOC"."AGROVOC_title") AS termtit
           FROM ke_stage."corpus_keywords_AGROVOC") m
     JOIN publ.agrovoc_mainheadings h ON m.idtit::text = h.id::text
WITH DATA;