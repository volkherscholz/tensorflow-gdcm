FROM tensorflow/tensorflow:2.2.0-gpu

# BUILD COMMANDS IF NECESSARY
RUN apt-get update && \
    pip install --upgrade pip && \
    apt-get install -y git cmake-curses-gui checkinstall swig && \
    mkdir gdcm && \ 
    cd gdcm && \
    git clone --branch release git://git.code.sf.net/p/gdcm/gdcm && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DGDCM_BUILD_SHARED_LIBS:BOOL=ON -DGDCM_WRAP_PYTHON=ON PYTHON_EXECUTABLE=/usr/local/bin/python3.6 PYTHON_INCLUDE_DIR=/usr/local/lib/python3.6/dist-packages/ ../gdcm && \
    checkinstall -D -y --pkgversion --pkgname=python3-gdcm --pkgversion=1

RUN cp /usr/local/lib/gdcm.py /usr/local/lib/python3.6/dist-packages/. && \
    cp /usr/local/lib/gdcmswig.py /usr/local/lib/python3.6/dist-packages/. && \
    cp /usr/local/lib/_gdcmswig.so /usr/local/lib/python3.6/dist-packages/. && \
    cp /usr/local/lib/libgdcm* /usr/local/lib/python3.6/dist-packages/.
RUN ldconfig
