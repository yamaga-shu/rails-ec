# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

DOCKER_COMPOSE_FILE = '.infra/development/compose.yml'
DOCKER_ENV_FILE = '.infra/development/.env'

namespace :docker do
  desc 'Build Docker containers with no cache'
  task :build do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} --env-file #{DOCKER_ENV_FILE} build --no-cache") || abort('Build failed')
  end

  desc 'Start Docker containers'
  task :up do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} --env-file #{DOCKER_ENV_FILE} up -d") || abort('Up failed')
  end

  desc 'Stop Docker containers'
  task :down do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} down") || abort('Down failed')
  end

  desc 'Show Docker container logs'
  task :logs do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} logs -f")
  end

  desc 'Execute shell in app container'
  task :shell do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} exec app bash")
  end
end