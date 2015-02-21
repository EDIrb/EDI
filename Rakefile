require "bundler/gem_tasks"

desc "RSpec"
task :rspec do
  system "bundle exec rspec"
end
desc "Cucumber"
task :cucumber do
  system "bundle exec cucumber"
end
task :default => [:rspec, :cucumber]
