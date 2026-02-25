-module(uuid_tests).

-include_lib("eunit/include/eunit.hrl").

v4_test() ->
    crypto:rand_seed_alg(crypto_aes, <<"v4_test">>),
    ?assertEqual("13d20f6f-f8b9-4ec3-bcd4-b09186df7a0f", uuid:v4()),
    ?assertEqual("536f58be-100d-480d-b704-1dc4acd9fb5f", uuid:v4()),
    ?assertEqual("8b670c84-733d-4814-95ed-606932393092", uuid:v4()).


v7_test() ->
    meck:new(uuid, [passthrough]),

    crypto:rand_seed_alg(crypto_aes, <<"v7_test">>),
    meck:expect(uuid, get_time, fun() -> 123 end),
    ?assertEqual("00000000-007b-79e8-84e5-8213c13efc29", uuid:v7()),
    ?assertEqual("00000000-007b-756f-a925-cbab30d9db28", uuid:v7()),
    ?assertEqual("00000000-007b-7b1f-a0c7-72d24b66cdf8", uuid:v7()),

    crypto:rand_seed_alg(crypto_aes, <<"v7_test">>),
    meck:expect(uuid, get_time, fun() -> 1770417428072 end),
    ?assertEqual("019c351a-1668-79e8-84e5-8213c13efc29", uuid:v7()),
    ?assertEqual("019c351a-1668-756f-a925-cbab30d9db28", uuid:v7()),
    ?assertEqual("019c351a-1668-7b1f-a0c7-72d24b66cdf8", uuid:v7()),

    crypto:rand_seed_alg(crypto_aes, <<"v7_test">>),
    meck:expect(uuid, get_time, fun() -> 1770417428073 end),
    ?assertEqual("019c351a-1669-79e8-84e5-8213c13efc29", uuid:v7()),
    ?assertEqual("019c351a-1669-756f-a925-cbab30d9db28", uuid:v7()),
    ?assertEqual("019c351a-1669-7b1f-a0c7-72d24b66cdf8", uuid:v7()),

    ?assert(meck:validate(uuid)),
    meck:unload(uuid).

v7_order_test() ->
    UUIdA = uuid:v7(),
    timer:sleep(15),
    UUIdB = uuid:v7(),
    ?assert(UUIdA < UUIdB).

