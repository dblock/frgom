# Live Code Walk Through

### Organize Yourself

I organize all my code in source and since I often fork code from others to contribute, create a subfolder with the Github username, including mine.

```
$ mkdir ~/source/frgom
$ mkdir ~/source/frgom/dblock
$ cd ~/source/frgom/dblock
```

You can read more about this in [A Directory Structure for OSS and Work Github Clones](http://code.dblock.org/2016/03/25/a-directory-structure-for-oss-and-work-github-clones.html).

### Git

```
$ git init

Initialized empty Git repository in /Users/dblock/source/frgom/dblock/.git
```

### Create a Github Repository

Create a [new repository on Github](https://github.com/new).

Add it as a remote.

```
$ git remote add origin git@github.com:dblock/frgom.git
```

#### Create a README

Documentation is written in Markdown. Create and commit a [README.md](README.md).

```
$ git add README.md
$ git commit -m "Added README."
[master acc5880] Added README.
1 file changed, 4 insertions(+)
create mode 100644 README.md
```

Push the README to Github.

```
$ git push origin master
Counting objects: 6, done.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (6/6), 963 bytes, done.
Total 6 (delta 0), reused 0 (delta 0)
To git@github.com:dblock/gf.git
* [new branch]      master -> master
```

#### Add a License

Every project needs a license. I use [the MIT license](https://github.com/dblock/frgom/blob/master/LICENSE.md) because it’s short and nobody has time to read licenses. Add [LICENSE.md](LICENSE.md) and a copyright notice to the [README](README.md), don't forget future contributors.

```
Copyright (c) 2018, Daniel Doubrovkine and Contributors. All Rights Reserved.

This project is licensed under the MIT license. See [LICENSE](LICENSE.md) for details.
```

Read more about the MIT license in [Becoming Open Source by Default](http://code.dblock.org/2015/02/09/becoming-open-source-by-default.html).

#### Gemfile

A [Gemfile](Gemfile) is needed by [bundler](http://gembundler.com) and declares gem dependencies.

Install bundler.

```
$ gem install bundler
Fetching: bundler-1.3.5.gem (100%)
Successfully installed bundler-1.3.5
1 gem installed
Installing ri documentation for bundler-1.3.5...
Installing RDoc documentation for bundler-1.3.5...
```

Create a [Gemfile](Gemfile). For now it just says where to get other gems from.

```ruby
source 'http://rubygems.org'
```

Run `bundle install`.

```
$ bundle install
Resolving dependencies...
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
```

#### .gitignore

The generated Gemfile.lock should not be included for libraries because all library dependencies must be explicitly listed in `gemspec`. Create a [.gitignore](.gitignore) and include `Gemfile.lock` in it.

```
Gemfile.lock
```

#### Library

Create [lib/frgom.rb](lib/frgom.rb) and [lib/frgom/version.rb](lib/frgom/version.rb).

```
require 'frgom/version'
```

```
module Frgom
  VERSION = '0.1.0'
end
```

#### Gem Declaration

Add [frgom.gemspec](frgom.gemspec), a gem declaration.

```
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'frgom/version'

Gem::Specification.new do |s|
  s.name = 'frgom'
  s.version = Frgom::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/frgom'
  s.licenses = ['MIT']
  s.summary = 'First ruby gem of many.'
end
```

The declaration can be loaded in [Gemfile](Gemfile), so that we can list dependencies in one place.

```
source 'http://rubygems.org'

gemspec
```

When running under bundler, the [Gemfile](Gemfile) will automatically be loaded, which will automatically load the gem specification.

```
$ bundle exec irb
:001 > require 'frgom'
=> true
:002 > Frgom::VERSION
=> "0.1.0"
```

#### Tests

You. Must. Test.

Add `rspec` to [Gemfile](Gemfile).

```
group :development, :test do
  gem 'rspec'
end
```

Tests need some setup, specifically to load the code in [lib](lib). Create [spec/spec_helper.rb](spec/spec_helper.rb). The first line adds `lib` to the load path, so that we can `require` files under `lib` without having to specify the entire path every time.

```
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'
require 'frgom'
```

Create a test in [spec/frgom/version_spec.rb](spec/frgom/version_spec.rb) for the version.

```
require 'spec_helper'

describe Frgom do
  it 'has a version' do
    expect(Frgom::VERSION).to_not be nil
  end
end
```

Add [.rspec](.rspec) to pretty-print test output.

```
--format documentation
--color
```

#### Rakefile

Most tasks are driven with `rake`. Add it to [Gemfile](Gemfile).

```
group :development, :test do
  gem 'rake'
end
```

Create a [Rakefile](Rakefile).

```
require 'bundler'

Bundler.setup(:default, :development)
```

#### Default Rakefile to Running Tests

Add RSpec rake tasks to [Rakefile](Rakefile).

```
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: [:spec]
```

Running `rake` will now run tests.

#### Travis-CI

Setup continuous integration with Travis-CI. Enable builds on [travis-ci.org](https://travis-ci.org) by syncing your account with Github, then ticking the build box for your project.

Add [.travis.yml](.travis.yml) for the Ruby project and speed builds up by caching dependencies.

```
language: ruby

cache: bundler

rvm:
  - 2.4.1
```

Add a badge to [README](README.md).

```
[![Build Status](https://travis-ci.org/dblock/frgom.png)](https://travis-ci.org/dblock/frgom)
```

Push the code to Github and make sure Travis-CI turns green.

#### Library Code

Your library should do something.

Create [fgrom/splines/b.rb](fgrom/splines/b.rb).

```
module Frgom
  module Splines
    class B
      def reticulated?
        !!@reticulated
      end

      def reticulate!
        @reticulated = true
      end
    end
  end
end
```

Create [fgrom/splines.rb](fgrom/splines.rb).

```
require_relative 'splines/b.rb'
```

Create [spec/fgrom/splines/b_spec.rb](spec/fgrom/splines/b_spec.rb).

```
require 'spec_helper'

describe Frgom::Splines::B do
  it 'is not reticulated by default' do
    expect(subject.reticulated?).to be false
  end
  context 'reticulated' do
    before do
      expect(subject.reticulate!).to be true
    end
    it 'is true' do
      expect(subject.reticulated?).to be true
    end
  end
end
```

A future improvement to this library should include shared spec behavior for all kinds of splines.

#### Rubocop

To avoid future debates about tabs vs. spaces, add RuboCop, a Ruby style linter.

Add `rubocop` to [Gemfile](Gemfile).

```
gem 'rubocop', '0.52.1'
```

Auto-generate a Rubocop configuration.

```
$ rubocop -a
$ rubocop --auto-gen-config
```

Add RuboCop tasks to [Rakefile](Rakefile).

```
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop spec]
```

I let Rubocop decide defaults for me and auto-correct my mistakes, so my work flow involves typing `rubocop -a ; rubocop --auto-gen-config` a lot. I included it in my default aliases as [ra](https://github.com/dblock/dotfiles/blob/acd4d8bd2a84535764664c5a2a7d5118b7e82a26/bash/.bash_aliases#L6). You can borrow other useful command-line tricks from [my dotfiles](https://github.com/dblock/dotfiles).

Running `rake` will now run tests and RuboCop.

#### Changelog

A good library tracks changes in a humanly readable format. It's more work, but I find it much more helpful than an automatic log. Create a [CHANGELOG.md](CHANGELOG.md) to list current and future updates. I like my specific format.

```
### 0.1.0 (Next)

* Initial public release - [@dblock](https://github.com/dblock).
* Your contribution here.
```

#### Contributing

Every library should welcome contributions. I add a default [CONTRIBUTING.md](CONTRIBUTING.md) by borrowing it from my previous projects and editing the project name and paths.

#### Releasing

We welcome future maintainers, so it's a good idea to add a [RELEASING.md](RELEASING.md) with simple instructions for releasing this library, including incrementing a version and updating CHANGELOG. I borrow it from my previous projects and edit the project name and paths.

#### Release Tasks

Bundler comes with a number of Rake tasks to release gems. Add them to [Rakefile](Rakefile).

```
require 'rubygems'
require 'bundler/gem_tasks'
```

You can see these tasks with `rake -T`.

```
$ rake -T
rake build    # Build frgom-0.1.0.gem into the pkg directory.
rake install  # Build and install frgom-0.1.0.gem into system gems.
rake release  # Create tag v0.1.0 and build and push frgom-0.1.0.gem to Rubygems
```

Build the library.

```
$ rake build
frgom 0.1.0 built to pkg/frgom-0.1.0.gem.
```

This generates output in `pgk`, so add `pkg/*` to `.gitignore`.

#### Release the Gem

Follow instruction in [RELEASING](RELEASING.md) to release the gem. This involves adding the release date for 0.1.0 and removing `Your contribution here.` from [CHANGELOG](CHANGELOG.md), committing those changes and typing `rake release`.

```
$ rake release
```

We follow [semantic versioning](https://semver.org), so bump the minor version in [version.rb](lib/frgom/version.rb) and add a _Next Release_ section to [CHANGELOG](CHANGELOG.md).

```
### 0.1.1 (Next)

* Your contribution here.
```

### Adding a CLI

We can now add a command line interface that can reticulate splines.

Add an executable and a dependency on `gli`, a command-line utility library, to [frgom.gemspec](frgom.gemspec).

```
s.executables << 'fgrom'
s.add_dependency 'gli'
```

Create a shell script in [bin/frgom](bin/frgom).

```
#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'gli'
require 'frgom'

include GLI::App

program_desc 'Reticulate splines.'

switch [:v, :verbose], desc: 'Produce verbose output.', default_value: false

default_command :help

desc 'Reticulate a spline.'
command :reticulate do |c|
  c.flag [:k, :kind], desc: 'Kind of spline to reticulate.', default_value: 'Frgom::Splines::B'
  c.action do |global_options, options, _args|
    kind = options[:kind].split('::').reduce(Module, :const_get)
    puts "Reticulating a #{kind} ..." if global_options[:verbose]
    kind.new.reticulate!
    exit_now! nil
  end
end

exit run(ARGV)
```

Make the script executable.

```
chmod 700 bin/frgom
```

Add tests for the new command-line interface as [spec/frgom/frgom_spec.rb](spec/frgom/frgom_spec.rb).

```
require 'spec_helper'

describe 'Command Line' do
  let(:bin) { File.expand_path(File.join(__FILE__, '../../../bin/frgom')) }
  describe '#help' do
    let(:outpiut) { `"#{bin}" help` }
    it 'displays help' do
      expect(output).to include 'frgom - Reticulate splines.'
    end
  end
  describe '#reticulate' do
    let(:output) { `"#{bin}" --verbose reticulate` }
    it 'reticulates a b-spline' do
      expect(output).to eq "Reticulating a Frgom::Splines::B ...\n"
    end
  end
end
```

Add a line to [CHANGELOG](CHANGELOG.md).

```
### 0.1.1 (Next)

* Added command line - [@dblock](https://github.com/dblock).
* Your contribution here.
```

With the next release of this library a user will be able to `gem install frgom` and use it from the command line.
