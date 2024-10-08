#!/bin/sh
occ_redis_install() {
  echo '## Configuring Redis...'

  occ config:system:set redis host --value="${NX_REDIS_HOST:?"NX_REDIS_HOST is unset"}"
  occ config:system:set redis password --value="${NX_REDIS_PASS:?"NX_REDIS_PASS is unset"}"
  occ config:system:set redis port --value="${NX_REDIS_PORT:-6379}"
  occ config:system:set memcache.local --value="\\OC\\Memcache\\APCu"
  occ config:system:set memcache.distributed --value="\\OC\\Memcache\\Redis"
  occ config:system:set memcache.locking --value="\\OC\\Memcache\\Redis"
}

occ_redis_remove() {
  echo '## Removing Redis Configuration...'

  occ config:system:set memcache.local --value="\\OC\\Memcache\\APCu"
  occ config:system:delete memcache.distributed
  occ config:system:delete memcache.locking
  occ config:system:delete redis
}
