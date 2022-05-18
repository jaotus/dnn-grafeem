#!/usr/bin/env bash

set -e

mkdir -p ossian-download
cd ossian-download

# Ossian
test ! -f master.zip && \
    wget https://github.com/CSTR-Edinburgh/Ossian/archive/refs/heads/master.zip

# Tools
HTK_USERNAME="********"
HTK_PASSWORD="********"
test ! -f HTK-3.4.1.tar.gz && \
    wget http://htk.eng.cam.ac.uk/ftp/software/HTK-3.4.1.tar.gz --http-user=$HTK_USERNAME --http-password=$HTK_PASSWORD
test ! -f HDecode-3.4.1.tar.gz  && \
    wget http://htk.eng.cam.ac.uk/ftp/software/hdecode/HDecode-3.4.1.tar.gz  --http-user=$HTK_USERNAME --http-password=$HTK_PASSWORD
test ! -f HTS-2.3alpha_for_HTK-3.4.1.tar.bz2 && \
    wget http://hts.sp.nitech.ac.jp/archives/2.3alpha/HTS-2.3alpha_for_HTK-3.4.1.tar.bz2
test ! -f hts_engine_API-1.05.tar.gz && 
    wget http://sourceforge.net/projects/hts-engine/files/hts_engine%20API/hts_engine_API-1.05/hts_engine_API-1.05.tar.gz
test ! -f SPTK-3.6.tar.gz && \
    wget http://downloads.sourceforge.net/sp-tk/SPTK-3.6.tar.gz
test ! -f romanian_toy_demo_corpus_for_ossian.tar && \
    wget "https://www.dropbox.com/s/uaz1ue2dked8fan/romanian_toy_demo_corpus_for_ossian.tar?dl=0" -O romanian_toy_demo_corpus_for_ossian.tar

cd ..

