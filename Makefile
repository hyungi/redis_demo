.PHONY: all compile clean test

REBAR = ./rebar3
REDIS_CONTAINER ?= bjosv/redis-cluster:6.2.0

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean
	@rm -rf _build

test:
	@ERL_FLAGS="-config test.config" $(REBAR) eunit -v

start:
	docker run --name redis-cluster -d -e IP=0.0.0.0 -e INITIAL_PORT=30001 \
	  -p 30001-30006:30001-30006 ${REDIS_CONTAINER}

stop:
	-docker rm -f redis-cluster
