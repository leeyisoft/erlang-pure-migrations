-module(db_dialect).

-export([ init/0
        , migrations_done/0
        , save_migration/2
        , latest_existing_version/0
        ]).

init() ->
    "CREATE TABLE IF NOT EXISTS database_migrations_history (
    version INTEGER NOT NULL PRIMARY KEY,
    filename varchar(255) NOT NULL,
    creation_timestamp TIMESTAMP NOT NULL DEFAULT NOW()
        )".

migrations_done() ->
  "SELECT version, filename FROM database_migrations_history".

save_migration(Version, Filename) ->
  lists:flatten(io_lib:format(
    "INSERT INTO database_migrations_history(version, filename) VALUES (~w, '~s')",
    [Version, Filename])).

latest_existing_version() ->
  "SELECT max(version) FROM database_migrations_history".
