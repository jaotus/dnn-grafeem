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
rm -rf train/* voices/*

# conda activate ossian
. /venv/bin/activate

# training Ossian front end (aligning data and getting lexicon)
python ./scripts/train.py -s $SPEAKER -l $LANGUAGE naive_01_nn || exit 1


# training Merlin's duration model
python ./tools/merlin/src/run_merlin.py \
        train/$LANGUAGE/speakers/$SPEAKER/naive_01_nn/processors/duration_predictor/config.cfg \
        || exit 1

# converting Merlin's duration model to Ossian's format
python ./scripts/util/store_merlin_model.py \
        train/$LANGUAGE/speakers/$SPEAKER/naive_01_nn/processors/duration_predictor/config.cfg \
        voices/$LANGUAGE/$SPEAKER/naive_01_nn/processors/duration_predictor || exit 1


# training Merlin's acoustic model
python ./tools/merlin/src/run_merlin.py \
        train/$LANGUAGE/speakers/$SPEAKER/naive_01_nn/processors/acoustic_predictor/config.cfg \
        || exit 1

# converting Merlin's acoustic model to Ossian's format
python ./scripts/util/store_merlin_model.py \
        train/$LANGUAGE/speakers/$SPEAKER/naive_01_nn/processors/acoustic_predictor/config.cfg \
        voices/$LANGUAGE/$SPEAKER/naive_01_nn/processors/acoustic_predictor || exit 1


mkdir -p test/{wav,txt}
echo "Un militar român a fost ucis, marţi, în Afganistan, iar un altul a fost rănit." >test/txt/romanian.txt
python ./scripts/speak.py -l $LANGUAGE -s $SPEAKER -o ./test/wav/romanian_test.wav naive_01_nn ./test/txt/romanian.txt

echo "Done! Try - aplay test/wav/romanian_test.wav"

