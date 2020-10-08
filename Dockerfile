# Build stage 0
FROM erlang:21

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Copy FMKe application
RUN mkdir fmke
COPY . fmke
WORKDIR fmke

# install erlang cassandra dependencies
RUN apt-get update && apt-get install -y \
g++ \
make \
cmake \
libssl-dev \
libuv1-dev \
&& rm -rf /var/lib/apt/lists/*

# build the release
RUN rm -rf _build/default/rel/
RUN rebar3 release -n fmke

# fix bug: after compiling, no env file
RUN cp /buildroot/fmke/bin/env /buildroot/fmke/_build/default/rel/fmke/bin/

RUN ["chmod", "+x", "/buildroot/fmke/run_fmke.sh"]

ENTRYPOINT ["/buildroot/fmke/run_fmke.sh"]    
