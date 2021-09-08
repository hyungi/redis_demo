redis_demo
=====

A wrapper OTP application of `eredis_cluster`

Compilation and tests
-----
```shell
$ make        # ... or rebar3 compile
$ make start  # Start local Redis clusters using Docker
$ make test   # Run tests towards the clusters
$ make stop   # Teardown the Redis clusters
```

