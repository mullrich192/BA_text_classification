#!/bin/bash

#change to directory containing the code
echo "change directory to folder /code"
cd code

#create dataset on db
echo "create dataset on db"
python 01_create_dataset_copy.ipynb

#detect language and join tables
echo "start language detection"
python 02_language_detection
psql -f 03_join_language.sql

#prepare agrovoc thesaurus and extract keywords 
echo "create lookup-list of agrovoc-thesaurus"
python 04_get_AGROVOC_data.ipynb
echo "extract keywords from title and abstract"
python 05_extract_keywords.ipynb
echo "mapping keywords with mainheadings"
psql -f 06_mesh_mainheadings_title.sql
psql -f 07_mesh_mainheadings_abs.sql
psql -f 08_agro_mainheadings_title.sql
psql -f 09_agro_mainheadings_abs.sql
echo "create final corpus agrovoc + mesh"
psql -f 10_create_corpus_mesh.sql
psql -f 11_create_corpus_agrovoc.sql

echo "run classification with LDA and SGD"
python 12.1_classification_LDA.ipynb
python 12.2_eval_LDA.ipynb
python 13_classification_SGD.ipynb