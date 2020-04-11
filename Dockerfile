FROM tensorflow/tensorflow:2.2.0rc2-gpu-py3

# Install build tools
RUN apt-get update && \
    apt-get install -y git swig cmake

# Compile gdcm from source
RUN mkdir gdcm && cd gdcm && \
    git clone --branch release git://git.code.sf.net/p/gdcm/gdcm && \
    mkdir gdcm-build && cd gdcm-build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DGDCM_BUILD_SHARED_LIBS:BOOL=ON -DGDCM_WRAP_PYTHON=ON PYTHON_EXECUTABLE=/usr/bin/python3.6 PYTHON_INCLUDE_DIR=/usr/local/lib/python3.6/dist-packages/ ../gdcm && \
    make && \ 
    cp bin/gdcm.py /usr/local/lib/python3.6/dist-packages/. && \
    cp bin/gdcmswig.py /usr/local/lib/python3.6/dist-packages/. && \
    cp bin/_gdcmswig.so /usr/local/lib/python3.6/dist-packages/. && \
    cp bin/libgdcm* /usr/local/lib/python3.6/dist-packages/.

WORKDIR /

# cleanup
RUN rm -rf /gdcm

