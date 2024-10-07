#!/bin/sh
occ_optimize() {
  echo '## Applying migrations/repairs/optimizations...'
  occ db:add-missing-indices
  occ db:add-missing-columns
  occ db:add-missing-primary-keys
  yes | occ db:convert-filecache-bigint
  occ maintenance:mimetype:update-js
  occ maintenance:mimetype:update-db
  occ maintenance:update:htaccess
}
