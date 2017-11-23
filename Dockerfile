FROM ubuntu:14.04

RUN apt-get update

# install dependencies
RUN apt-get install -y build-essential libqt4-dev libyaml-dev swig python-dev pkg-config git wget
RUN apt-get install -y python-numpy-dev python-numpy python-yaml yasm

# fetch libraries
RUN git clone https://github.com/MTG/gaia.git
RUN wget https://github.com/MTG/essentia/archive/v2.1_beta3.tar.gz
RUN wget https://libav.org/releases/libav-12.tar.gz
#RUN wget http://essentia.upf.edu/documentation/svm_models/essentia-extractor-svm_models-v2.1_beta1.tar.gz

# install libav
RUN tar -xzvf libav-12.tar.gz
RUN cd libav-12 \
	&& ./configure --enable-shared \
	&& make \
	&& make install

# install gaia
RUN cd gaia \
  && ./waf configure \
  && ./waf \
  && ./waf install

# install other dependencies
RUN apt-get install -y libfftw3-dev python-dev libsamplerate0-dev libtag1-dev

# install essentia
RUN tar -xzvf v2.1_beta3.tar.gz essentia-2.1_beta3/
RUN cd essentia-2.1_beta3/ \
	&& ./waf configure --with-gaia --with-vamp --with-examples --with-python \
	&& ./waf \
	&& ./waf install
RUN ldconfig

#put svm models in place
#RUN tar -xzvf essentia-extractor-svm_models-v2.1_beta1.tar.gz
#RUN cp -R /v2.1_beta1/svm_models /svm_models

WORKDIR /essentia