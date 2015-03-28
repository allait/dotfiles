require 'rake'
require './dotfiles'

components.each do |component|
  namespace component do
    load "#{component}/Rakefile" if File.exist?("#{component}/Rakefile")
  end
end

desc 'Install dotfiles to $HOME'
task install: [:info, :pull] do
  components.each do |component|
    if Rake::Task.task_defined? "#{component}:install"
      Rake::Task["#{component}:install"].invoke
    else
      linkables(component).each do |linkable|
        install_item(linkable)
      end
    end
  end
end

task :pull do
  next if ENV['skip'] && ENV['skip'].include?('pull')
  `git pull`
  puts 'Initializing submodules...'
  `git submodule update --init --rebase`
  Dir['.git/modules/vim/vim/bundle/*'].each do |mod|
    `echo "doc/tags" > '#{mod}/info/exclude'`
  end
end

desc 'Remove installed dotfiles and restore from backup'
task :uninstall do
  components.each do |component|
    if Rake::Task.task_defined? "#{component}:uninstall"
      Rake::Task["#{component}:uninstall"].invoke
    else
      linkables(component).each do |linkable|
        uninstall_item(linkable)
      end
    end
  end
  `rm -rf $HOME/.backup $HOME/tmp $HOME/wiki`
end

task default: 'install'

desc 'Clean tmp backup and swap files'
task :clean do
  `rm -rf $PWD/build`
  `rm -rf $HOME/tmp/swap $HOME/tmp/backup $HOME/tmp/undo`
  `mkdir -p $HOME/tmp/swap $HOME/tmp/backup $HOME/tmp/undo`
end

desc 'Create tmp dirs and info files'
task :info do
  next if File.exist?("#{ENV['HOME']}/tmp/info")
  `mkdir -p $HOME/tmp/info $HOME/tmp/swap $HOME/tmp/backup $HOME/tmp/undo`
  print 'Name: '
  name = STDIN.gets.chomp
  `echo '#{name}' > $HOME/tmp/info/name`
  print 'Email: '
  email = STDIN.gets.chomp
  `echo '#{email}' > $HOME/tmp/info/email`
end

desc 'Update pathogen and sumbodules'
task :update do
  `curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim > vim/vim/autoload/pathogen.vim`
  `git submodule foreach git pull origin master`
  `git submodule foreach git fetch`
  system %(git status)
end

desc 'Setup wiki link'
task :wiki do
  next unless File.exist?('../wiki')
  `ln -s "$PWD/../wiki" "$HOME/wiki"` unless File.symlink?("#{ENV['HOME']}/wiki")
end

desc 'Install node.js and npm'
task :install_node do
  system %(brew install node)
  system %(curl http://npmjs.org/install.sh | sh)
  system %(brew cleanup)
end
