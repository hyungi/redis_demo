%%%-------------------------------------------------------------------
%%% @author CORP\hyungi.seong
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(redis_demo).

-behaviour(application).

-export([start/0, start/2, stop/1, q/1, qa/1]).

-include("eredis_cluster.hrl").
-include("redis_demo_utils.hrl").

start() ->
    start([{"127.0.0.1", 30001}], [{pool_size, 10}, {pool_max_overflow, 0}, {password, ""}]).

-spec start(InitServers, Options) -> ok
    when InitServers :: [{Address :: string(),
    Port :: inet:port_number()}],
    Options :: options().
start(InitServers, Options) ->
    io:format(?MODULE),

    eredis_cluster:start(),
    application:set_env(eredis_cluster, pool_size, lookup(pool_size, Options, 5)),
    application:set_env(eredis_cluster, pool_max_overflow, lookup(pool_max_overflow, Options, 5)),
    eredis_cluster:connect(InitServers).

stop(_State) ->
    ok.

-spec qa(Command) -> Result
            when Command :: redis_command(),
                 Result  :: [redis_transaction_result()] |
                            {error, no_connection}.
qa(Command) -> eredis_cluster:qa(Command).

-spec q(Command :: redis_command()) -> redis_result().
q(Command) ->
    eredis_cluster:q(Command).
