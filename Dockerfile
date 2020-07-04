FROM tensorflow/tensorflow:2.2.0-gpu

# BUILD COMMANDS IF NECESSARY
RUN apt-get update && \
    pip install --upgrade pip && \
    apt install -y cmake-curses-gui checkinstall swig && \
    mkdir gdcm && \ 
    cd gdcm && \
    git clone --branch release git://git.code.sf.net/p/gdcm/gdcm && \
    mkdir build && cd build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DGDCM_BUILD_SHARED_LIBS:BOOL=ON -DGDCM_WRAP_PYTHON=ON PYTHON_EXECUTABLE=/usr/local/bin/python3.6 PYTHON_INCLUDE_DIR=/usr/local/lib/python3.6/dist-packages/ ../gdcm
RUN checkinstall -D -y --pkgversion --pkgname=python3-gdcm --pkgversion=1

RUN cp /usr/local/lib/gdcm.py /usr/local/lib/python3.6/dist-packages/.
RUN cp /usr/local/lib/gdcmswig.py /usr/local/lib/python3.6/dist-packages/.
RUN cp /usr/local/lib/_gdcmswig.so /usr/local/lib/python3.6/dist-packages/.
RUN cp /usr/local/lib/libgdcm* /usr/local/lib/python3.6/dist-packages/.
RUN ldconfig


# Install build tools
# RUN apt-get update && \
#    apt-get install -y git swig cmake

# Compile gdcm from source
# RUN mkdir gdcm && cd gdcm && \
#    git clone --branch release git://git.code.sf.net/p/gdcm/gdcm && \
#     mkdir gdcm-build && cd gdcm-build && \
#    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DGDCM_BUILD_SHARED_LIBS:BOOL=ON -DGDCM_WRAP_PYTHON=ON PYTHON_EXECUTABLE=/usr/bin/python3.6 PYTHON_INCLUDE_DIR=/usr/local/lib/python3.6/dist-packages/ ../gdcm && \
#    make && \ 
#    cp bin/gdcm.py /usr/local/lib/python3.6/dist-packages/. && \
#    cp bin/gdcmswig.py /usr/local/lib/python3.6/dist-packages/. && \
#    cp bin/_gdcmswig.so /usr/local/lib/python3.6/dist-packages/. && \
#    cp bin/libgdcm* /usr/local/lib/python3.6/dist-packages/.

#RUN apt install -y python-vtk6 libvtk6-dev cmake-curses-gui checkinstall swig
#RUN mkdir gdcm && cd gdcm && git clone --branch release git://git.code.sf.net/p/gdcm/gdcm
#RUN mkdir build && cd build
#RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DGDCM_BUILD_SHARED_LIBS:BOOL=ON -DGDCM_WRAP_PYTHON=ON PYTHON_EXECUTABLE=/usr/local/bin/python3.6 PYTHON_INCLUDE_DIR=/usr/local/lib/python3.6/site-packages/ GDCM_BUILD_SHARED_LIBS=ON GDCM_USE_VTK=ON ../gdcm
#RUN checkinstall -D -y --pkgversion --pkgname=python3-gdcm --pkgversion=1

# WORKDIR /

# cleanup
# RUN rm -rf /gdcm

