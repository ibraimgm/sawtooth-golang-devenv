FROM golang:1.11

# apt and system packages
RUN echo "deb http://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/Debian_9.0/ ./" >> /etc/apt/sources.list && \
wget https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/Debian_9.0/Release.key -O- | apt-key add - && \
apt-get update && \
apt-get install -y python3 python3-pip protobuf-compiler libzmq3-dev && \
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 && \
update-alternatives --install /usr/bin/python python /usr/bin/python3 2

# python bs
RUN python -m pip install --upgrade pip && \
python -m pip install grpcio && \
python -m pip install grpcio-tools

# golang
RUN go get -u github.com/golang/protobuf/protoc-gen-go && \
go get github.com/golang/mock/gomock && \
go get golang.org/x/tools/go/packages && \
go install github.com/golang/mock/mockgen && \
go get github.com/pebbe/zmq4 && \
go get github.com/satori/go.uuid && \
go get github.com/hyperledger/sawtooth-sdk-go && \
cd /go/src/github.com/hyperledger/sawtooth-sdk-go/ && \
go generate

# install code-server
RUN wget https://github.com/cdr/code-server/releases/download/1.939-vsc1.33.1/code-server1.939-vsc1.33.1-linux-x64.tar.gz && \
tar -xzvf code-server1.939-vsc1.33.1-linux-x64.tar.gz && \
mv code-server1.939-vsc1.33.1-linux-x64 /code && \
rm code-server1.939-vsc1.33.1-linux-x64.tar.gz

CMD ["/code/code-server", "--allow-http", "--no-auth"]
