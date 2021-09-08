%%%-------------------------------------------------------------------
%% @doc redis_demo top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(redis_demo_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

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
    ok = redis_demo:start(),
    SupFlags = #{strategy => one_for_one,
        intensity => 5,
        period => 10},

    {ok, {SupFlags, []}}.

%% internal functions
