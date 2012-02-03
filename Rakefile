require 'rake'
require 'dotfiles'

components().each do |component|
  namespace component do
    load "#{component}/Rakefile" if File.exists?("#{component}/Rakefile")
  end
end

desc "Install dotfiles to user HOME"
task :install => [:info] do
  install(components(), :local)
  system %Q[git submodule update --init]
end

desc "Install minimal set of dotfiles"
task :remote => [:info] do
  install([:vim, :git, :zsh], :remote)
end

desc "Remove installed dotfiles and restore from backup"
task :uninstall do
  components().each do |component|
    if Rake::Task.task_defined? "#{component}:uninstall"
      Rake::Task["#{component}:uninstall"].invoke
    else
      linkables(component).each do |linkable|
        uninstall_item(linkable)
      end
    end
  end
  `rm -rf $HOME/{tmp,wiki}`
end

# task :default => 'install'

desc "Clean tmp backup and swap files"
task :cleanup do
  `rm -rf $HOME/tmp/{swap,backup,undo}`
  `mkdir -p $HOME/tmp/{swap,backup,undo}`
end

desc "Create info files"
task :info do
  next if File.exists?("#{ENV["HOME"]}/tmp/info")
  `mkdir -p $HOME/tmp/info`
  print "Name: "
  name = STDIN.gets.chomp
  `echo '#{name}' > $HOME/tmp/info/name`
  print "Email: "
  email = STDIN.gets.chomp
  `echo '#{email}' > $HOME/tmp/info/email`
end

desc "Update pathogen and sumbodules"
task :update do
    `curl https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim > vim/autoload/pathogen.vim`
    `git submodule foreach git pull origin master`
    `git submodule foreach git fetch`
    system %Q[git status]
end

desc "Setup wiki link"
task :wiki do
  next if not File.exists?("../wiki")
  `ln -s "$PWD/../wiki" "$HOME/wiki"` if not File.symlink?("#{ENV["HOME"]}/wiki")
end

desc "Install rvm and ruby"
task :install_ruby do
    system %Q[curl -sk https://rvm.beginrescueend.com/install/rvm | bash]
    `source ~/.rvm/scripts/rvm`
    system %Q[rvm install 1.8.7]
    system %Q[rvm use --default 1.8.7]
end

desc "Install node.js and npm"
task :install_node do
    system %Q[brew install node]
    system %Q[curl http://npmjs.org/install.sh | sh]
    system %Q[brew cleanup]
end
