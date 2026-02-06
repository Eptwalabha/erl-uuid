-module(uuid).

-export([v4/0]).
-export([v7/0]).

v4() ->
    <<A:32, B:16, C:12, D:14, E:48, _:6>> = uuid:strong_rand(16),
    to_str([<<A:32>>, <<B:16>>, <<4:4, C:12>>, <<2:2, D:14>>, <<E:48>>]).

v7() ->
    Timestamp = uuid:get_time(),
    <<A:32, B:16>> = <<Timestamp:48>>,
    <<C:12, D:14, E:48, _:6>> = uuid:strong_rand(10),
    to_str([<<A:32>>, <<B:16>>, <<7:4, C:12>>, <<2:2, D:14>>, <<E:48>>]).

to_str([_, _, _, _, _] = Parts) ->
    UUId = lists:join(<<"-">>, [binary:encode_hex(P) || P <- Parts]),
    string:lowercase(UUId).

get_time() ->
    os:system_time(millisecond).

strong_rand(Size) ->
    crypto:strong_rand_bytes(Size).
