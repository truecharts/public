# Installation Notes

Zammad strongly recommends configurating Elasticsearch and Memcached, despite being optional.

## Zammad Parameters

- The `Autowizard JSON` parameter allows you to provide initial configuration data for your instance. Autowizard JSON is out of scope of this documentation, however [this example file](https://github.com/zammad/zammad/blob/stable/contrib/auto_wizard_example.json) should help. The default value is empty.


### Web Concurrency Parameters
- The `Web Concurrency (Instances)` parameter allows spawning `n` workers to allow more simultaneous connections for Zammad's web interface. If you fill this out then fill out the rest of the Web Concurrency section. The default value is empty.

- The `Concurrent Session Jobs` parameter allows specifying the amount of instances of the session worker to run at a time. Increasing this can speed up background jobs (like the scheduler) when too many users are on Zammad at once. Generally speaking, it should only be useful to adjust this setting if you have more than 40 active users at a time. The default value is empty.

- The `Independent Process for Scheduled Jobs` parameter allows you to enable or disable independent processes for jobs such as LDAP syncs. This can free up the Zammad background worker for other tasks when some scheduled tasks are fairly long. The default value is false.

- The `Processes for Delayed Jobs` parameter allows you to specify the amount of processes that should work on delayed jobs. Increasing this can improve issues with delayed jobs stacking up in your system. You may want to try to use `Concurrent Session Jobs` before though. This option can be very CPU intensive. The default value is empty, and the maximum value is 16.

### Dependency Configuration

#### Rails
- The `Rails Trusted Proxies` parameter allows you to change the trusted proxies. The default value is `['127.0.0.1', '::1']`, changing this isn't recommended unless you know what you're doing.

#### Redis (Optional)
- The `Redis URL` parameter allows you to store your web socket conection within Redis, and should point to your Redis instance `redis://location:6379`. The default value is empty. If not provided, Zammad falls back to the file system (`/opt/zammad/tmp/websocket_*`).

#### Memcached (Optional)
- The `Memcached Servers` parameter allows you to store your application cache files within Memcached, and should point to your Memcached instance `location:11211`. The default value is empty. If not provided, Zammad falls back to the file system (`/opt/zammad/tmp/cache*`).

#### Elasticsearch (Optional)
- The `Elasticsearch Enable` parameter allows you to enable Elasticsearch, which is enabled by default and is the recommended configuration.

- The `Elasticsearch URL` parameter should point to your Elasticsearch instance's endpoint, and should either be the host name or IP address.

- The `Elasticsearch Port` parameter should point to your Elasticsearch instance's port. The default value is `9200`.

- The `Elasticsearch Schema` parameter allows you to specify the schema of Elasticsearch. The default value is `http`.

- The `Elasticsearch Namespace` parameter allows you to specify a namespace to all Zammad related indexes will be created. Change this if you're using external clusters.

- The `Elasticsearch Reindex` parameter is for enabling reindexing on startups, which may be troublesome on larger installations. Disabling this setting requires you to re-index your search index manually whenever that's needed by upgrading to a new Zammad version! This is enabled by default.

- The `Elasticsearch SSL Verify` parameter allows you to let the compose scripts ignore self signed SSL certificates for your Elasticsearch installation if needed. This is enabled by default.
