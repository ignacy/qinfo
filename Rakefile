require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "qinfo"
    gemspec.summary = "MySQL Query Info"
    gemspec.description = "Benchmarks SQL queries using Ruby"
    gemspec.email = "imoryc@gmail.com"
    gemspec.homepage = "http://github.com/ignacy/qinfo"
    gemspec.authors = ["Ignacy Moryc"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

############################

require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/*_spec.rb']
end

desc "Print specdocs"
Spec::Rake::SpecTask.new(:doc) do |t|
  t.spec_opts = ["--format", "specdoc", "--dry-run"]
  t.spec_files = FileList['spec/*_spec.rb']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = FileList['spec/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'examples']
end


desc "Prepare test database"
Spec::Rake::SpecTask.new('prepare_test') do |t|
  require 'mysql2'
  require 'yaml'

  config_file = File.dirname(__FILE__) + '/config.yml'
  config = YAML::parse( File.open(File.expand_path(config_file)))
  user = config["user"].value
  password = config["password"].value
  database = config["base"].value
  %x[mysql -u #{user} --password=#{password} #{database} < default_test_data.sql]
  @qonection = Mysql2::Client.new(:host => "localhost", :username => user, :password => password, :database => database)
  100.times do |time|
    @qonection.query("INSERT INTO accounts (name, surname, credits, age) VALUES ('john_#{time}', 'kowalski_#{time}', #{rand(1000)}, #{rand(60)})")
  end
end

task :default => :spec
