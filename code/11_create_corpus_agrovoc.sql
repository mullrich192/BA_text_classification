-- publ.corpus_keywords_agro source

CREATE MATERIALIZED VIEW publ.corpus_keywords_agro
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
        )
 SELECT a.id1,
    a.agro_title,
    b.id2,
    b.agro_abs
   FROM agro_title a
     FULL JOIN agro_abs b ON a.id1::text = b.id2::text
WITH DATA;