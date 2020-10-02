# Build stage 0
FROM erlang:21

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Copy FMKe application
RUN mkdir fmke
COPY . fmke

# install erlang cassandra dependencies
RUN apt-get update
RUN apt-get install -y g++ make cmake libssl-dev libuv1-dev

# And build the release
WORKDIR fmke
RUN rm -rf _build/default/rel/
RUN rebar3 release -n fmke

RUN ["chmod", "+x", "/buildroot/fmke/run_fmke.sh"]

ENTRYPOINT ["/buildroot/fmke/run_fmke.sh"]    
