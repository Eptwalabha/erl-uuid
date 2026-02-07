# uuid

Generate uuid version 4 & 7

```erlang
> uuid:v4().
"ef381427-61a2-4201-bd97-21b295bea06f"
> uuid:v7().
"019c353b-c7e8-7fb6-a387-cd2c14626505"
```

# Installation

Add `uuid_v47` to the dependencies in your `rebar.config`:
```
{deps, [{uuid_v47, "1.0.1"}]}
% or
{depts, [{uuid_v47, {git, "https://github.com/Eptwalabha/erl-uuid.git", {tag, "v1.0.1"}}}]}
```
then fetch and compile the dependencies of your project:
```bash
rebar3 compile --deps_only
```
That's it, you're good to go.
