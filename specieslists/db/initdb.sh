#!/bin/bash
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/ONLY_FULL_GROUP_BY.sql
