-- ke_stage.join_language source

CREATE MATERIALIZED VIEW ke_stage.join_language
TABLESPACE pg_default
AS SELECT cs.dbrecordid,
    cs.title,
    cs.abstract,
    cl.lang_title,
    cl.lang_abs
   FROM ke_stage.corpus_small_train cs
     JOIN ke_stage.corpus_language cl ON cs.dbrecordid = cl.dbrecordid
WITH DATA;