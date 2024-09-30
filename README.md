# 1.Ruby On Rails with Docker - Template
Use this code and follow the instructions below to create and run a new rails application using Docker & Docker Compose.

# 2.Instructions

Go to your projects or work directory and
```
git clone git@github.com:Minhtu12394/Docker-Rails-Template.git myapp
cd myapp
rm -rf .git
docker-compose run app rails new . --force --database=mysql --skip-bundle
mv database.yml config/database.yml
cp .env.example .env
docker-compose build
docker-compose up
```
Then: http://localhost:3000/

# 3.Some command
rails g scaffold post title body:text
use this instead
docker-compose run --rm app rails g scaffold post title body:text

Because I don't want to install Rails so all command use  Docker
ex:
docker-compose run --rm app
# 4.Rails API-only
docker-compose run app rails new . --force --database=mysql --skip-bundle --api
