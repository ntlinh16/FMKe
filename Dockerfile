# Build stage 0
FROM erlang:21

# Set working directory
RUN mkdir -p /buildroot/fmke
WORKDIR /buildroot/fmke

# Copy FMKe application
COPY . .

# install erlang cassandra dependencies
RUN apt-get update && apt-get install -y \
g++ \
make \
cmake \
libssl-dev \
libuv1-dev \
&& rm -rf /var/lib/apt/lists/*

# build the release
RUN rebar3 release -n fmke

# fix bug: after compiling, no env file
RUN cp bin/env _build/default/rel/fmke/bin/ \
    && chmod +x run_fmke.sh


ENTRYPOINT ["/buildroot/fmke/run_fmke.sh"]    
