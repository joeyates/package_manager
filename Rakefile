require 'rubygems' if RUBY_VERSION < '1.9'
require 'rake'
require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'rake/rdoctask'
$:.unshift( File.dirname( __FILE__ ) + '/lib' )
require 'package_manager'

TITLE        = 'A package manager abstraction'
ADMIN_FILES  = FileList[ 'Rakefile', 'README.rdoc' ]
EXECUTABLES  = FileList[ 'bin/*' ]
SOURCE_FILES = FileList[ 'lib/**/*.rb' ]
SPEC_FILES   = FileList[ 'spec/**/*' ]
RDOC_FILES   = FileList[ 'README.rdoc' ] + EXECUTABLES + SOURCE_FILES
RDOC_OPTS    = [ '--quiet', '--main', 'README.rdoc', '--inline-source' ]

EXECUTABLE_FILENAMES = EXECUTABLES.collect { | file | file.gsub( %r(^bin/), '' ) }

spec = Gem::Specification.new do |s|
  s.name              = 'package_manager'
  s.summary           = TITLE
  s.description       = 'Unifies the command interface for using yum and apt on Linux, Fink and MacPorts on OS X'
  s.version           = PackageManager::VERSION::STRING

  s.homepage          = 'http://github.com/joeyates/package_manager'
  s.author            = 'Joe Yates'
  s.email             = 'joe.g.yates@gmail.com'
  s.rubyforge_project = "nowarning"


  s.files             = ADMIN_FILES +
                        EXECUTABLES +
                        SOURCE_FILES
  s.executables       += EXECUTABLE_FILENAMES
  s.require_paths     = [ 'lib' ]
  s.add_dependency( 'rake', '>= 0.8.7' )

  s.has_rdoc          = true
  s.rdoc_options      += RDOC_OPTS
  s.extra_rdoc_files  = RDOC_FILES

  s.test_files        = SPEC_FILES
end

Rake::GemPackageTask.new( spec ) {}

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList[ 'spec/**/*_spec.rb' ]
  t.spec_opts  += [ '--color', '--format specdoc' ]
end

Spec::Rake::SpecTask.new( 'spec:rcov' ) do |t|
  t.spec_files = FileList[ 'spec/**/*_spec.rb' ]
  t.rcov       = true
  t.rcov_opts  = [ '--exclude spec' ]
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'html'
  rdoc.options  += RDOC_OPTS
  rdoc.title    = TITLE
  rdoc.rdoc_files.add RDOC_FILES
end
