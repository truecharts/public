# Installation Notes

Elasticsearch and Memcached are preconfigured dependencies as part of this installation, and shouldn't require additional configuration.

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

#### Elasticsearch

- The `Elasticsearch Reindex` parameter is for enabling reindexing on startups, which may be troublesome on larger installations. Disabling this setting requires you to re-index your search index manually whenever that's needed by upgrading to a new Zammad version. This is enabled by default.