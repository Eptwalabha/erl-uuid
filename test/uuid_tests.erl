-module(uuid_tests).

-include_lib("eunit/include/eunit.hrl").

v4_test() ->
    meck:new(uuid, [passthrough]),
    StrongRandBytes1 = list_to_binary(lists:duplicate(16, 0)),
    meck:expect(uuid, strong_rand, fun(16) -> StrongRandBytes1 end),
    ?assertEqual("00000000-0000-4000-8000-000000000000", uuid:v4()),

    StrongRandBytes2 = list_to_binary(lists:seq(1, 16)),
    meck:expect(uuid, strong_rand, fun(16) -> StrongRandBytes2 end),
    ?assertEqual("01020304-0506-4070-a024-282c3034383c", uuid:v4()),

    StrongRandBytes3 = <<15, 251, 70, 107, 55, 189, 44, 77,
                         4, 222, 156, 183, 98, 117, 255, 138>>,
    meck:expect(uuid, strong_rand, fun(16) -> StrongRandBytes3 end),
    ?assertEqual("0ffb466b-37bd-42c4-b413-7a72dd89d7fe", uuid:v4()),

    ?assert(meck:validate(uuid)),
    meck:unload(uuid).

v7_test() ->
    meck:new(uuid, [passthrough]),
    StrongRandBytes1 = list_to_binary(lists:duplicate(10, 0)),
    meck:expect(uuid, strong_rand, fun(10) -> StrongRandBytes1 end),

    meck:expect(uuid, get_time, fun() -> 123 end),
    ?assertEqual("00000000-007b-7000-8000-000000000000", uuid:v7()),

    meck:expect(uuid, get_time, fun() -> 1770417428072 end),
    ?assertEqual("019c351a-1668-7000-8000-000000000000", uuid:v7()),

    meck:expect(uuid, get_time, fun() -> 1770417428073 end),
    ?assertEqual("019c351a-1669-7000-8000-000000000000", uuid:v7()),

    StrongRandBytes2 = <<170, 162, 238, 243, 51, 51, 51, 51, 51, 0>>,
    meck:expect(uuid, strong_rand, fun(10) -> StrongRandBytes2 end),
    ?assertEqual("019c351a-1669-7aaa-8bbb-cccccccccccc", uuid:v7()),

    ?assert(meck:validate(uuid)),
    meck:unload(uuid).

v7_order_test() ->
    UUIdA = uuid:v7(),
    timer:sleep(15),
    UUIdB = uuid:v7(),
    ?assert(UUIdA < UUIdB).

