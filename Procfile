web:     bundle exec rails server -b 0.0.0.0
worker:  bundle exec sidekiq -C config/sidekiq.yml
db:      postgres -D /usr/local/var/postgres
redis:   redis-server /usr/local/etc/redis.conf
release: bundle exec rails db:migrate
