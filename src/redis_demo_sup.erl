%%%-------------------------------------------------------------------
%% @doc redis_demo top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(redis_demo_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).
-include("redis_demo_utils.hrl").

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    io:format(redis_demo_sup),
    ClientOptions = default_client_options(),
    PoolOptions = default_pool_options(),
    ok = redis_demo:start(ClientOptions, PoolOptions),
    SupFlags = #{strategy => one_for_one,
        intensity => 5,
        period => 10},

    {ok, {SupFlags, []}}.

%% internal functions
default_client_options() ->
    [{?GET_ENV(barker_server_ip, ?DEFAULT_IP), ?GET_ENV(barker_server_port, ?DEFAULT_PORT)}].

default_pool_options() ->
    [
        {pool_size, ?GET_ENV(pool_size, ?DEFAULT_POOL_SIZE)},
        {max_retries, ?GET_ENV(pool_max_overflow, ?DEFAULT_POOL_OVERFLOW)}
    ].
