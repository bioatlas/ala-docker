#!/bin/bash
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/schema.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/eventLogType.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/reasonLogType.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/sourceLogType.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/refresh_summary_breakdown_email.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/refresh_summary_breakdown_reason.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/refresh_summary_totals.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/update_breakdown_summary_information.sql
${mysql[@]} -v < /docker-entrypoint-initdb.d/tmp/definer_user.sql