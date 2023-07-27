#!/bin/bash

#change to directory containing the code
echo -e "change directory to /code"
cd code


function prepare_data {
    echo "$1" "create dataset on db" # arguments are accessible through $1, $2,...
    python 01_create_dataset_copy.ipynb 
}


function language_detection () {
    echo "$2" "detect Language" # arguments are accessible through $1, $2,...
    python 02_language_detection
    psql -f 03_join_language.sql
}

function keywords () {
    echo "$3" "prepare Thesaurus and extract keywords" 
    python 05_extract_keywords.ipynb
    psql -f 06_mesh_mainheadings_title.sql
    psql -f 07_mesh_mainheadings_abs.sql
    psql -f 08_agro_mainheadings_title.sql
    psql -f 09_agro_mainheadings_abs.sql
    psql -f 10_create_corpus_mesh.sql
    psql -f 11_create_corpus_agrovoc.sql
}

function classification () {
    echo "$4" "run classification with LDA and SGD"
    python 12.1_classification_LDA.ipynb
    python 12.2_eval_LDA.ipynb
    python 13_classification_SGD.ipynb
}