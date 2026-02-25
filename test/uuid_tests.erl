-module(uuid_tests).

-include_lib("eunit/include/eunit.hrl").

v4_test() ->
    crypto:rand_seed_alg(crypto_aes, <<"v4_test">>),
    ?assertEqual("14d31070-f9ba-4ed4-80d8-b4958ae37e13", uuid:v4()),
    ?assertEqual("547059bf-110e-481d-bb08-21c8b0ddff63", uuid:v4()),
    ?assertEqual("8c680d85-743e-4824-99f1-646d363d3496", uuid:v4()).


v7_test() ->
    meck:new(uuid, [passthrough]),

    crypto:rand_seed_alg(crypto_aes, <<"v7_test">>),
    meck:expect(uuid, get_time, fun() -> 123 end),
    ?assertEqual("00000000-007b-79f8-88e9-8617c543002d", uuid:v7()),
    ?assertEqual("00000000-007b-757f-ad29-cfaf34dddf2c", uuid:v7()),
    ?assertEqual("00000000-007b-7b2f-a4cb-76d64f6ad1fc", uuid:v7()),

    crypto:rand_seed_alg(crypto_aes, <<"v7_test">>),
    meck:expect(uuid, get_time, fun() -> 1770417428072 end),
    ?assertEqual("019c351a-1668-79f8-88e9-8617c543002d", uuid:v7()),
    ?assertEqual("019c351a-1668-757f-ad29-cfaf34dddf2c", uuid:v7()),
    ?assertEqual("019c351a-1668-7b2f-a4cb-76d64f6ad1fc", uuid:v7()),

    crypto:rand_seed_alg(crypto_aes, <<"v7_test">>),
    meck:expect(uuid, get_time, fun() -> 1770417428073 end),
    ?assertEqual("019c351a-1669-79f8-88e9-8617c543002d", uuid:v7()),
    ?assertEqual("019c351a-1669-757f-ad29-cfaf34dddf2c", uuid:v7()),
    ?assertEqual("019c351a-1669-7b2f-a4cb-76d64f6ad1fc", uuid:v7()),

    ?assert(meck:validate(uuid)),
    meck:unload(uuid).

v7_order_test() ->
    UUIdA = uuid:v7(),
    timer:sleep(15),
    UUIdB = uuid:v7(),
    ?assert(UUIdA < UUIdB).

