#!/bin/bash

#change to directory containing the code
echo "set settings"
echo "change directory to folder /code"
cd code

#create dataset on db
echo "create dataset on database"
jupyter nbconvert --execute --to notebook 01_create_dataset.ipynb

#detect language and join tables
echo "start language detection"
jupyter nbconvert --execute --to notebook 02_language_detection.ipynb 
psql postgres -f 03_join_language.sql

#prepare agrovoc thesaurus and extract keywords 
echo "create lookup-list of agrovoc-thesaurus"
jupyter nbconvert --execute --to notebook 04_get_AGROVOC_data.ipynb

echo "extract keywords from title and abstract"
jupyter nbconvert --execute --to notebook 05_extract_keywords.ipynb

echo "mapping keywords with mainheadings"
psql postgres -f 06_mesh_mainheadings_title.sql
psql postgres -f 07_mesh_mainheadings_abs.sql
psql postgres -f 08_agro_mainheadings_title.sql
psql postgres -f 09_agro_mainheadings_abs.sql

echo "create final corpus agrovoc + mesh"
psql postgres -f 10_create_corpus_mesh.sql
psql postgres -f 11_create_corpus_agrovoc.sql

echo "run classification with LDA and SGD"
jupyter nbconvert --execute --to notebook 12.1_classification_LDA.ipynb
jupyter nbconvert --execute --to notebook 12.2_eval_LDA.ipynb
jupyter nbconvert --execute --to notebook 13_classification_SGD.ipynb