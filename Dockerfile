FROM debian:buster-slim

WORKDIR /
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -fy wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion build-essential liblapack-dev libblas-dev libffi-dev libzmq3-dev sbcl && \
    apt-get clean

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

RUN wget --quiet https://downloads.rigetti.com/qcs-sdk/forest-sdk-linux-deb.tar.bz2 && \
    tar -xf forest-sdk-linux-deb.tar.bz2 && \
    rm *.bz2 && \
    mv forest*/forest*.run forest-sdk.run && \
    ./forest-sdk.run --accept && \
    rm -rf forest*

RUN pip install pyquil

RUN pip install qiskit
RUN pip install qiskit-terra[visualization]

EXPOSE 8888

RUN printf "#!/bin/sh \nnohup quilc -S & \nnohup qvm -S & \njupyter notebook --ip=0.0.0.0 --port=8888 --allow-root" > /run.sh

CMD [ "/bin/sh", "run.sh" ]
