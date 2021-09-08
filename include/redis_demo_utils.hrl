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
