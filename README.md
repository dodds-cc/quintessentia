# Dockerfile for Essentia v2.1_beta3 + GAIA (Ubuntu 14.04)

Configured with examples (command-line feature extractors), python bindings and vamp plugin and GAIA for higher-level extractions.

Image downloads: https://hub.docker.com/r/doddscc/quintessentia/
This image is a rework of the official image available at: https://github.com/MTG/essentia-docker but with added GAIA support.

## Usage examples

### Music extractor
Analyze a file ```audio.wav``` located in the current directory and write results to the same directory:
```
docker run -ti --rm -v `pwd`:/essentia mtgupf/essentia essentia_streaming_extractor_music audio.wav audio.sig
```

### Freesound extractor
The same, but using Freesound extractor:
```
docker run -ti --rm -v `pwd`:/essentia mtgupf/essentia essentia_streaming_extractor_freesound audio.wav audio.json
```

### Essentia in python
Run a python script using Essentia located in the current directory:
```
docker run -ti --rm -v `pwd`:/essentia mtgupf/essentia python test.py
```

### Essentia with GAIA high-level extraction
I have not included the svm models in the docker container, you must provide these.
First download the SVM models from the essentia site, for example: http://essentia.upf.edu/documentation/svm_models/essentia-extractor-svm_models-v2.1_beta1.tar.gz

Unzip and place svm_models folder in the same folder as you will run you docker container from.
You can now run this command to extract lower-level features, saving as audio.sig
```
docker run -ti --rm -v `pwd`:/essentia mtgupf/essentia essentia_streaming_extractor_music audio.wav audio.json
```
Then you pass the lower-level extraction into the svm extractor, providing you with higherLevel.json
```
docker run -ti --rm -v `pwd`:/essentia mtgupf/essentia essentia_streaming_extractor_music_svm audio.json higherLevel.json
```
