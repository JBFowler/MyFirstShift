# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

```shell
rvm install ruby-2.4.0
```

* System dependencies



* Configuration



* Database creation

* Database initialization

* How to run the test suite

* Deployment instructions

* ...
# onboarding

Setup

#### 1. Configs

```shell
bundle install
cp config/database.yml.sample config/database.yml
```

#### 2. Database

```shell
brew install postgres
```

If you don’t already have brew services installed. It may be installed with this command:

```shell
brew tap homebrew/services
```

#### 3. DNS & nginx/passenger

DNS

```shell
localhost:3000
```

Seeded Subdomain

```shell
myfirstshift.localhost:3000
```

Login information can be found in `db/seeds.rb`

#### 4. Deployment


