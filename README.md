# Backend micro services for Micose App !

# Contributing
## Mac OS X
### Install Mongo
```shell
# Install with homebrew
brew update;
brew install mongodb --with-openssl;
# Create database directory
mkdir -p ~/data/db;
# Launch 
mongod --dbpath ~/data/db &;
```

Sources: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/

### Intall Elixir
```shell
# Install with hombrew
brew update;
brew install elixir;
```

### Launch app
```shell
# Get dependencies
mix deps.get
# Launch test
mix test
```