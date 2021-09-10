%%%-------------------------------------------------------------------
%%% @author CORP\hyungi.seong
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. Sep 2021 오후 5:39
%%%-------------------------------------------------------------------
-author("CORP\hyungi.seong").

%% public
-export([
  lookup/3
]).

%% public
-spec lookup(atom(), [{atom(), term()}], term()) ->
  term().

lookup(Key, List, Default) ->
  case lists:keyfind(Key, 1, List) of
    false -> Default;
    {_, Value} -> Value
  end.

%% Taken from rtb-gateway
-define(GET_ENV(Key), application:get_env(?APP, Key)).
-define(GET_ENV(Key, Default), application:get_env(?APP, Key, Default)).

-define(DEFAULT_IP, "127.0.0.1").
-define(DEFAULT_PORT, 30001).
-define(DEFAULT_POOL_SIZE, 5).
-define(DEFAULT_POOL_OVERFLOW, 0).

-define(APP, redis_demo).
