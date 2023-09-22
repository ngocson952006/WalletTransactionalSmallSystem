docker-compose build
docker-compose run --rm app rake db:setup
docker-compose run --rm app rake db:migrate
docker-compose run --rm app rake db:seed

docker-compose up
