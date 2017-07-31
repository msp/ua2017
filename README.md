# Unconscious Archives Festival 2017

https://ua2017.unconscious-archives.org


## Local setup

```bash
# get src & libs
$ git clone https://github.com/msp/ua2017.git
$ cd ua2017 && mix deps.get

# create and migrate your database
$ mix ecto.create && mix ecto.migrate

# install Node.js dependencies for UI
$ npm install

# start Phoenix endpoint
$ mix phoenix.server
```
Visit [`localhost:4000`](http://localhost:4000) in your browser.

## Test / Develop

```bash
# local test guard
$ mix test.watch

# start the server
$ iex -S mix phoenix.server

```

## Deployment

Heroku based deploys:

### Production
```bash
$ git remote add production https://git.heroku.com/ua2017.git

$ git push production master
```

### Sitemap
```bash
AWS_ACCESS_KEY_ID=123 AWS_SECRET_ACCESS_KEY=asdf POOL_SIZE=2 mix do app.start, sitemap.generate
```

## Learn more

### Project

  * About UA2017: https://ua2017.unconscious-archives.org/about

### Tech

  * Elixir: http://elixir-lang.org/install.html
  * Phoenix: http://www.phoenixframework.org/
