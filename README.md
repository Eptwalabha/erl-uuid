# uuid
[![erlarg CI](https://github.com/Eptwalabha/erl-uuid/actions/workflows/ci.yml/badge.svg)](https://github.com/Eptwalabha/erl-uuid/actions/workflows/ci.yml)

A small and tested library to generate uuid version 4 & 7

# Installation

Add `uuid_v47` to the dependencies in your `rebar.config`:
```
{deps, [{uuid_v47, "1.2.1"}]}
% or
{depts, [{uuid_v47, {git, "https://github.com/Eptwalabha/erl-uuid.git", {tag, "v1.0.1"}}}]}
```
then fetch and compile the dependencies of your project:
```bash
rebar3 compile --deps_only
```
That's it, you're good to go.


# Usage

```erlang
> uuid:v4().
"ef381427-61a2-4201-bd97-21b295bea06f"
> uuid:v7().
"019c353b-c7e8-7fb6-a387-cd2c14626505"
```

## Using seed

use `crypto:rand_seed_alg` to seed the uuid
```erlang
> crypto:rand_seed_alg(crypto_aes, <<"my seed">>).
> uuid:v4().
"86bf7f93-c61f-45b3-b94e-c871dca40304"
> crypto:rand_seed_alg(crypto_aes, <<"my seed">>).
> uuid:v4().
"86bf7f93-c61f-45b3-b94e-c871dca40304"
```

> [!TIP]
> To some extends, it also works with `uuid:v7/0`
