# onboarding

* Ruby version

```shell
rvm install ruby-2.4.0
```

* Builds

#### Dev

#### Qa - (Staging ENV needs to be setup)

#### Master

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

And then you can run the following command to start Postgres as a background service:

```shell
brew services start postgresql
```

Postgres will also restart automatically at login after you have run the command above.
Once Postgres has started, we can use `brew services` to stop it manually

```shell
brew services stop postgresql
```

Or we can also use `brew services` to restart Postgres

```shell
brew services restart postgresql
```

#### 3. DNS

DNS for Development

```shell
localhost:3000
```

Seeded Subdomain for local development

```shell
myfirstshift.localhost:3000
```

Super Admin portal can be found in `routes.rb:23`

Login information can be found in `db/seeds.rb`

#### 4. Deployment - Heroku

Install Heroku Toolbelt

* Mac OS

```shell
brew install heroku/brew/heroku
```

* Debian/Ubuntu

```shell
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
```

Heroku Login

```shell
heroku login
```

Clone the source of the application

```shell
heroku git:clone -a myfirstshift
```

Deploy to Heroku

```shell
git push heroku master
```

To Run Migrations

```shell
heroku run rake db:migrate
```

To check status of application and view logs, see https://devcenter.heroku.com/articles/getting-started-with-rails5#visit-your-application

To run Rails Console

```shell
heroku run rails console
```

#### Test Suite

```shell
rspec spec
```



