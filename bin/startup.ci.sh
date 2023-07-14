#!/usr/bin/env bash
set -e

/opt/wait-for-it.sh database:5432
#yarn migration:run
#yarn seed:run
yarn start:prod > /dev/null 2>&1 &
/opt/wait-for-it.sh maildev:1080
yarn lint
yarn test:e2e -- --runInBand
