#!/bin/bash

if ! [[ -z "${DATABASE_ADDRESSES}" ]]; then
    sed -i -e "s/{database_addresses, .*}\./{database_addresses, [\"$DATABASE_ADDRESSES\"]}\./g" /buildroot/fmke/_build/default/rel/fmke/config/fmke.config
fi

if ! [[ -z "${DATABASE_PORTS}" ]]; then
    sed -i -e "s/{database_ports, .*}\./{database_ports, [$DATABASE_PORTS]}\./g" /buildroot/fmke/_build/default/rel/fmke/config/fmke.config
fi

if ! [[ -z "${TARGET_DATABASE}" ]]; then
    sed -i -e "s/{target_database, .*}\./{target_database, $TARGET_DATABASE}\./g" /buildroot/fmke/_build/default/rel/fmke/config/fmke.config
fi

if ! [[ -z "${OPTIMIZED_DRIVER}" ]]; then
    sed -i -e "s/{optimized_driver, .*}\./{optimized_driver, $OPTIMIZED_DRIVER}\./g" /buildroot/fmke/_build/default/rel/fmke/config/fmke.config
fi

if ! [[ -z "${CONNECTION_POOL_SIZE}" ]]; then
    sed -i -e "s/{connection_pool_size, .*}\./{connection_pool_size, $CONNECTION_POOL_SIZE}\./g" /buildroot/fmke/_build/default/rel/fmke/config/fmke.config
fi

if ! [[ -z "${HTTP_PORT}" ]]; then
    sed -i -e "s/{http_port, .*}\./{http_port, $HTTP_PORT}\./g" /buildroot/fmke/_build/default/rel/fmke/config/fmke.config
fi

IP=172.18.0.2 /buildroot/fmke/_build/default/rel/fmke/bin/env foreground 
