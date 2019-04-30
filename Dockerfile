FROM golang:1.11

# install code-server
RUN wget https://github.com/cdr/code-server/releases/download/1.939-vsc1.33.1/code-server1.939-vsc1.33.1-linux-x64.tar.gz && \
tar -xzvf code-server1.939-vsc1.33.1-linux-x64.tar.gz && \
mv code-server1.939-vsc1.33.1-linux-x64 /code && \
rm code-server1.939-vsc1.33.1-linux-x64.tar.gz

CMD ["/code/code-server", "--allow-http", "--no-auth"]
