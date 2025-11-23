DOCKER_COMPOSE_FILE = ".infra/development/compose.yml"

namespace :docker do
  desc "Build Docker containers with no cache"
  task :build do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} build --no-cache") || abort("Build failed")
  end

  desc "Start Docker containers"
  task :up do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} up -d") || abort("Up failed")
  end

  desc "Stop Docker containers"
  task :down do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} down") || abort("Down failed")
  end

  desc "Show Docker container logs"
  task :logs do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} logs -f app")
  end

  desc "Execute shell in app container"
  task :shell do
    system("docker compose -f #{DOCKER_COMPOSE_FILE} exec app bash")
  end
end
