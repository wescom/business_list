namespace :webpack do
  task :build do
    on roles(:app) do
#      execute "cd #{release_path} && ./bin/webpack"
      execute "cd #{release_path} && bundle exec rake webpacker:compile RAILS_ENV=production"
    end
  end
end