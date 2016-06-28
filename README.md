# PRpal

[![CircleCI](https://circleci.com/gh/zach-taylor/PRpal.svg?style=svg)](https://circleci.com/gh/zach-taylor/PRpal)
[![codebeat badge](https://codebeat.co/badges/cf7a44db-2e63-406d-9f87-73ea39255706)](https://codebeat.co/projects/github-com-zach-taylor-prpal)

PRpal is a tool that enforces peer review by requiring the assignee
of your pull request to give a +1.

## How it Works

It's simple: PRpal ensures that the assignee of your pull request has commented with a +1 (or the
+1 emoji). It enforces this rule by using the GitHub Status API.

## Deploy to Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Setup

1. Follow the instructions for deploying above
2. Go to the app's root url: `https://your-app.herokuapp.com/`
3. Click "Log In"
4. Grant the app access to your GitHub account
5. Once logged in, select "Refresh Repos" to sync your repositories
6. Select "Activate" on the repos you would like to enforce (and that you have admin access to on GitHub)
7. If you would like, go to the repo's settings in GitHub, and require a positive status check for 'peer-review/PRpal' in order to merge

## Development

1. Requirements: Postgres, Redis, rvm or rbenv
2. Clone the repo
3. Install the gems: `$ bundle install`
4. Start the server: `$ foreman start`
5. Setup the database: `$ rails db:schema:load`
6. Run the tests: `$ rails test`