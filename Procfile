# FULL APP RUN
# docker-compose up -d postgres; rm .overmind.sock; overmind s
# 
# APP RUN:
# overmind s
# 
# postgres: docker-compose up postgres
rails: export DATABASE_URL=postgres://postgres:postgres@localhost:5400 && rails s -p 5000
webpacker: ./bin/webpack-dev-server
