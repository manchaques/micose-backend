# Backend micro services for Micose App !

# Contributing
## Mac OS X
### Install PostgreSQL
```shell
# Install with homebrew
brew update;
brew install postgresql;
# Install Lunchy
sudo gem install lunchy
# Add Postgresql to LaunchAgents
cp /usr/local/Cellar/postgresql/9.5.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
# Launch PostgreSQL with Lunchy 
lunchy start postgres

# Create Phoenix dev config
psql postgres
> CREATE USER postgres;
> ALTER USER postgres PASSWORD 'postgres';
> ALTER USER postgres WITH SUPERUSER;

# Create database
mix ecto.create
```

Sources: https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/

### Install Elixir
```shell
# Install with hombrew
brew update;
brew install elixir;
```

Sources: http://elixir-lang.org/install.html#mac-os-x

### Launch app
```shell
# Get dependencies
mix deps.get
# Launch test
mix test
# Launche backend
mix phoenix.server
```

## Tips and tricks
### Generate a new resource
```shell
# Ex: generate a Book resource
mix phoenix.gen.json Book books title:string owner:string borrower:string
```

### Update the database schema
```shell
mix ecto.migrate
```

### Add a model in ExAdmin
```shell
mix admin.gen.resource Book
```