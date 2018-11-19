# JsonapiIssue134

To recreate the issue:

  * `mix deps.get`
  * `mix ecto.setup`
  * `cd assets && npm install`
  * `mix test --only jsonapi`

