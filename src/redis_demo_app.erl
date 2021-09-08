%%%-------------------------------------------------------------------
%% @doc redis_demo public API
%% @end
%%%-------------------------------------------------------------------

-module(redis_demo_app).

-behaviour(application).

%% Application
-export([start/0, stop/0]).
%% Application callback
-export([start/2, stop/1]).

-include("eredis_cluster.hrl").

-spec start() -> ok | {error, Reason::term()}.
start() ->
    application:start(?MODULE).

-spec stop() -> ok | {error, Reason::term()}.
stop() ->
    application:stop(?MODULE).

start(_StartType, _StartArgs) ->
    redis_demo_sup:start_link().

stop(_State) ->
    ok.
