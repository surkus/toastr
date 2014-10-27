$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "toastr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "toastr"
  s.version     = Toastr::VERSION
  s.authors     = ["MBeller, DRush"]
  s.email       = []
  s.homepage    = "http://github.com/drush/toastr"
  s.summary     = "Serve stale data to views instead of no data for expensive and long-running queries or reports"
  s.description = "Serve stale data to views and generate updates in the background"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency "aasm"
  s.add_dependency 'delayed_job_active_record'


  s.add_development_dependency "sqlite3"
end
