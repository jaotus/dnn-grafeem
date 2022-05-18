#!/usr/bin/env bash

LANGUAGE=rm
SPEAKER=rss_toy_demo
test "$1" && LANGUAGE=$1
test "$2" && SPEAKER=$2

echo $LANGUAGE
echo $SPEAKER

export LANG=C.utf8
export THEANO_FLAGS=""
export USER=tester

# conda activate ossian
. /venv/bin/activate

mkdir -p test/{wav,txt}
echo "Un militar român a fost ucis, marţi, în Afganistan, iar un altul a fost rănit." >test/txt/romanian.txt
python ./scripts/speak.py -l $LANGUAGE -s $SPEAKER -o ./test/wav/romanian_test.wav naive_01_nn ./test/txt/romanian.txt

echo "Done! Try - aplay test/wav/romanian_test.wav"
