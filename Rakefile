require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "qinfo"
    gemspec.summary = "MySQL Query Info"
    gemspec.description = "Benchmarks SQL query against MySQL/OS facilities"
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

task :default => :spec
