require 'erb'

module Dot
    All = FileList['*'].exclude('Rakefile', 'build', "*.[^ed]*")
    Build = All.map {|x| '.' + x.sub('.erb','')}
    System = `uname -s`.strip.downcase
    Home = Build.map{|x| File.join(ENV['HOME'], x)}
    Dirs = {
        :build => File.join(Dir.pwd, 'build/'),
        :old => File.join(ENV['HOME'], '.old/'),
        :home => ENV["HOME"],
        :bundle => File.join(Dir.pwd, 'vim/bundle/'),
    }

    def self.home_path(file)
        File.join(Dirs[:home], ".#{file.sub('.erb','')}")
    end

    def self.old_path(file)
        File.join(Dirs[:old], ".#{file.sub('.erb','')}")
    end

    def self.file_parts(file)
         FileList["#{file.sub('.erb','')}.local.#{System}", "#{home_path(file)}.local"]
    end

    def self.colorize(text, color_code)
        "#{color_code}#{text}\e[0m"
    end

    def self.red(text)
        colorize(text, "\e[31m")
    end

    def self.green(text)
        colorize(text, "\e[32m")
    end

    def self.build_file(file)
        parts = file_parts(file).existing
        if File.directory?(file)
            if not File.exists?(home_path(file)):
                puts "Symlinking directory .#{file}..."
                %x[ln -s #{File.join(Dir.pwd, file)} #{home_path(file)}]
            else
                puts green("#{file} symlink found!")
            end
            return
        end
        if File.symlink?(home_path(file))
            puts green(".#{file} symlink found!")
            return
        end
        # If not changed, leave as is
        if FileUtils.uptodate?(home_path(file), [parts, file].flatten)
            puts green(".#{file} is up-to-date!")
            return
        end
        # Else, delete old one
        %x[rm -f #{home_path(file)}]
        # If *.erb - render template
        if file =~ /.erb$/
            puts "Rendering #{file}..."
            File.open(home_path(file), 'w') do |render_file|
                render_file.write ERB.new(File.read(file)).result(binding)
            end

        # Else copy base
        elsif parts.empty?
            puts "Symlinking file #{file}..."
            %x[ln -s #{File.join(Dir.pwd, file)} #{home_path(file)}]
        else
            puts "Copying file #{file}..."
            %x[cp #{file} #{home_path(file)}]
        end
        # Append file.local parts
        parts.each do |part|
            puts "Appending #{part} to #{file}..."
            %x[cat #{part} >> #{home_path(file)}]
        end
    end
end

desc "Install dotfiles"
task :install => [:cleanup, :build, :wiki, :clean_tmp] do
    puts "Initializing vim plugins..."
    %x[git submodule init]
    %x[git submodule update]
end

desc "Clean tmp backup and swap files"
task :clean_tmp do
    if File.exists?(File.join(Dot::Dirs[:home], '/tmp/swap')):
        puts "Deleting swap..."
        %x[rm -rf #{File.join(Dot::Dirs[:home], '/tmp/swap')}]
    end
    if File.exists?(File.join(Dot::Dirs[:home], '/tmp/backup')):
        puts "Deleting backup..."
        %x[rm -rf #{File.join(Dot::Dirs[:home], '/tmp/backup')}]
    end
    if File.exists?(File.join(Dot::Dirs[:home], '/tmp/undo')):
        puts "Deleting undo..."
        %x[rm -rf #{File.join(Dot::Dirs[:home], '/tmp/undo')}]
    end
    puts "Creating tmp dir..."
    %x[mkdir -p #{File.join(Dot::Dirs[:home], '/tmp/swap')}]
    %x[mkdir -p #{File.join(Dot::Dirs[:home], '/tmp/undo')}]
    %x[mkdir -p #{File.join(Dot::Dirs[:home], '/tmp/backup')}]
end

desc "Create info files"
task :create_info do
    if not File.exists?(File.join(Dot::Dirs[:home], '/tmp/info')):
        %x[mkdir -p #{File.join(Dot::Dirs[:home], '/tmp/info')}]
        print "Name: "
        name = STDIN.gets.chomp
        %x[echo '#{name}' > ~/tmp/info/name]
        print "Email: "
        email = STDIN.gets.chomp
        %x[echo '#{email}' > ~/tmp/info/email]
    end
end


desc "Remove symlinks and restore files from .old"
task :uninstall => [:cleanup] do
    if File.exists?(Dot::Dirs[:old])
        puts "Restoring backup..."
        Dot::All.each do |df|
            if File.exist?(Dot.old_path(df))
                %x[mv #{Dot.old_path(df)} #{Dot::Dirs[:home]}]
                puts "Restored #{Dot.home_path(df)}!"
            end
        end
        puts Dot.red("Deleting backup dir...")
        rm_r Dot::Dirs[:old]
    end
end


desc "Quick dotfile rebuild"
task :up => [:create_info] do
    Dot::All.each do |df|
        Dot.build_file df
    end
end

desc "Update pathogen and sumbodules"
task :update do
    %x[curl https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim > vim/autoload/pathogen.vim]
    %x[git submodule foreach git pull origin master]
    %x[git submodule foreach git fetch]
    puts `git status`
end

desc "Backup existing config to .old folder"
task :backup do
    if not File.exists?(Dot::Dirs[:old])
        puts "Starting backup to #{Dot::Dirs[:old]}..."
        %x[mkdir #{Dot::Dirs[:old]}]
        Dot::All.each do |df|
            if File.exist?(Dot.home_path(df))
                %x[cp -r #{Dot.home_path(df)} #{Dot::Dirs[:old]}]
                puts "Copied #{df} to backup folder"
            end
        end
    end
end

desc "Remove dotfiles from HOME dir"
task :cleanup => [:backup, :clean_tmp] do
    Dot::All.each do |df|
        if File.exists?(Dot.home_path(df))
            puts Dot.red("Deleting #{df}...")
            %x[rm -rf #{Dot.home_path(df)}]
        end
    end
    # Remove wiki links and html dir
    if File.exists?(File.join(Dot::Dirs[:home], '*wiki_html'))
        puts Dot.red("Deleting wiki rendered html folder...")
        %x[rm -r #{File.join(Dot::Dirs[:home], '*wiki_html')}]
    end
    if File.exists?(File.join(Dot::Dirs[:home], 'wiki'))
        puts Dot.red("Deleting wiki symlink...")
        %x[rm #{File.join(Dot::Dirs[:home], 'wiki')}]
    end
    # Remove info files
    if File.exists?(File.join(Dot::Dirs[:home], 'tmp/info'))
        puts Dot.red("Deleting info files...")
        %x[rm -rf #{File.join(Dot::Dirs[:home], 'tmp/info')}]
    end
end

desc "Execute full build for current machine"
task :build => [:up, :update] do
end

desc "Setup wiki link"
task :wiki do
    if File.exists?(File.join(Dir.pwd,'..','wiki'))
        puts "Setting up wiki..."
        %x[ln -s #{File.join(Dir.pwd, '..', 'wiki')} #{Dot::Dirs[:home] + '/wiki'}]
    end
end

desc "Create build dir"
task :create_build_dir do
    if not File.exists?(Dot::Dirs[:build])
        puts "Creating build directory..."
        %x[mkdir #{Dot::Dirs[:build]}]
    end
end

desc "Build latest macvim from github"
task :install_macvim => [:create_build_dir] do
    puts "Cloning macvim..."
    macvim_path = File.join(Dot::Dirs[:build], 'macvim')
    if File.exists?(macvim_path)
        %x[cd #{macvim_path}; git pull]
    else
        %x[git clone git://github.com/b4winckler/macvim.git  #{macvim_path}]
        puts "Downloading icons..."
        %x[cd #{macvim_path}/src/MacVim/icons; curl http://cloud.github.com/downloads/b4winckler/macvim/MacVim-docicon-pack.tbz | tar xj]
    end
    puts "Configuring macvim..."
    %x[cd #{macvim_path}/src; ./configure --with-features=huge \
          --enable-rubyinterp \
          --enable-pythoninterp \
          --enable-perlinterp \
          --enable-cscope \
          --with-macarchs=x86_64 \
          --with-macsdk=10.6 ]
    puts "Building MacVim..."
    %x[cd #{macvim_path}/src; make]
    puts "Copying mvim script..."
    %x[cp #{macvim_path}/src/MacVim/mvim /usr/local/bin/]
    %x[open #{macvim_path}/src/MacVim/build/Release/]
end

desc "Setup common python packages"
task :install_pip_tools do
    %x[pip install -U -r requirements.txt]
end

desc "Install common tools from homebrew packages"
task :install_brew_tools do
    puts "Installing Homebrew packages..."
    packages = [
        "git",
        "ack",
        "ctags",
        "gnu-sed",
        "par",
        "irssi",
        "proctools",
        "wget",
        "w3m",
    ]
    packages.each do |pack|
        puts "Installing #{pack}..."
        %x[brew install #{pack}]
    end
    puts "Linking..."
    %x[brew link ctags]
    puts "Cleaning up..."
    %x[brew cleanup]
end

desc "Install common tools from npm packages"
task :install_npm_tools do
    puts "Installing npm packages..."
    packages = [
        "http-console",
        "nodelint",
        "coffee-script"
    ]
    packages.each do |pack|
        puts "Installing #{pack}..."
        %x[npm install -g #{pack}]
    end
end

desc "Install common gems"
task :install_gems do
    packages = [
        "cheat",
        "facter"
    ]
    packages.each do |pack|
        puts "Installing #{pack}..."
        %x[gem install #{pack}]
    end
end

desc "Install python interpreter"
task :install_python do
    puts "Installing python..."
    puts %x[brew install python --framework]
    puts "Linking python framework..."
    puts %x[sudo rm /Library/Frameworks/Python.framework/Versions]
    puts %x[sudo ln -is $(find /usr/local/Cellar/python -type l -name Current) /Library/Frameworks/Python.framework/Versions]
    puts "Installing pip..."
    puts %x[/usr/local/share/python/easy_install pip]
    puts "Upgrading distribute..."
    puts %x[/usr/local/share/python/pip install --upgrade distribute]
    puts "Cleaning up..."
    %x[brew cleanup]
end

desc "Install rvm and ruby"
task :install_ruby do
    puts "Installing rvm..."
    puts %x[curl -sk https://rvm.beginrescueend.com/install/rvm | bash]
    %x[source ~/.rvm/scripts/rvm]
    puts "installing ruby..."
    puts %x[rvm install 1.8.7]
    puts %x[rvm use --default 1.8.7]
end

desc "Install node.js and npm"
task :install_node do
    puts "Installing node..."
    puts %x[brew install node]
    puts "Installing npm..."
    puts %x[curl http://npmjs.org/install.sh | sh]
    puts "Cleaning up..."
    %x[brew cleanup]
end
