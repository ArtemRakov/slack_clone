test:
	bin/rails rspec

clean:
	bin/rails db:drop

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:migrate
	bin/rails db:fixtures:load

start:
	bundle exec heroku local

lint:
	bundle exec rubocop

linter-fix:
	bundle exec rubocop --auto-correct

deploy:
	git push heroku master

lsp-configure:
	bundle exec yard gems
	bundle exec solargraph bundle

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

.PHONY: test
