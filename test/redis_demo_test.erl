%%%-------------------------------------------------------------------
%%% @author CORP\hyungi.seong
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Sep 2021 오후 7:40
%%%-------------------------------------------------------------------
-module(redis_demo_test).
-author("CORP\hyungi.seong").

-include_lib("eunit/include/eunit.hrl").
-include("eredis_cluster.hrl").

-define(Setup, fun() -> redis_demo:start() end).

basic_test_() ->
    {inorder,
        {setup, ?Setup,
            [
                {"get and set",
                    fun() ->
                        ?assertEqual({ok, <<"OK">>}, redis_demo:q(["SET", "key", "value"])),
                        ?assertEqual({ok, <<"value">>}, redis_demo:q(["GET", "key"])),
                        ?assertEqual({ok, undefined}, redis_demo:q(["GET", "nonexists"]))
                    end
                },

                { "query all - failing",
                    fun () ->
                        %% Only one node will give ok, others will fail
                        Result = redis_demo:qa(["set", "Key1", "test"]),
                        ?assertMatch({ok,    <<"OK">>}, proplists:lookup(ok, Result)),
                        ?assertMatch({error, <<"MOVED", _/binary>>},
                            proplists:lookup(error, Result))
                    end
                }
            ]
        }
    }.
