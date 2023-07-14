#!/usr/bin/env bash
set -e

/opt/wait-for-it.sh database:5432
yarn migration:run
yarn seed:run
yarn start:dev
