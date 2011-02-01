require 'erb'

module Dot
    All = FileList['*'].exclude('Rakefile', 'build', "*.[^e]*")
    Build = All.map {|x| '.' + x.sub('.erb','')}
    System = `uname -s`.strip.downcase
    Home = Build.map{|x| File.join(ENV['HOME'], x)}
    Dir = {
        :build => File.join(pwd, 'build/', System),
        :old => File.join(ENV['HOME'], '.old/'),
        :home => ENV["HOME"],
        :bundle => File.join(pwd, 'vim/bundle/'),
    }

    def self.home_path(file)
        File.join(Dir[:home], ".#{file.sub('.erb','')}")
    end

    def self.old_path(file)
        File.join(Dir[:old], ".#{file.sub('.erb','')}")
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
        # If directory, symlink to build/system
        if File.directory?(file) 
            if not File.exists?(home_path(file)):
                puts "Symlinking directory .#{file}..."
                %x[ln -s #{File.join(pwd, file)} #{home_path(file)}]
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
        if uptodate?(home_path(file), [parts, file].flatten)
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
            %x[ln -s #{File.join(pwd, file)} #{home_path(file)}]
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
    if File.exists?(File.join(Dot::Dir[:home], '/tmp/swap')):
        puts "Deleting swap..."
        %x[rm -rf #{File.join(Dot::Dir[:home], '/tmp/swap')}]
    end
    if File.exists?(File.join(Dot::Dir[:home], '/tmp/backup')):
        puts "Deleting backup..."
        %x[rm -rf #{File.join(Dot::Dir[:home], '/tmp/backup')}]
    end
    puts "Creating tmp dir..."
    %x[mkdir -p #{File.join(Dot::Dir[:home], '/tmp/swap')}]
    %x[mkdir -p #{File.join(Dot::Dir[:home], '/tmp/backup')}]
end

desc "Remove symlinks and restore files from .old"
task :uninstall => [:cleanup] do
    if File.exists?(Dot::Dir[:old])
        puts "Restoring backup..."
        Dot::All.each do |df|
            if File.exist?(Dot.old_path(df))
                %x[mv #{Dot.old_path(df)} #{Dot::Dir[:home]}]
                puts "Restored #{Dot.home_path(df)}!"
            end
        end
        puts Dot.red("Deleting backup dir...")
        rm_r Dot::Dir[:old]
    end
end


desc "Quick dotfile rebuild"
task :up do
    Dot::All.each do |df|
        Dot.build_file df
    end
end

desc "Update pathogen and sumbodules"
task :update do
    # TODO pathogen update,
    %x[git submodule foreach git pull origin master]
    %x[git submodule foreach git fetch]
    puts `git status`
end

desc "Backup existing config to .old folder"
task :backup do
    if not File.exists?(Dot::Dir[:old])
        puts "Starting backup to #{Dot::Dir[:old]}..."
        %x[mkdir #{Dot::Dir[:old]}]
        Dot::All.each do |df|
            if File.exist?(Dot.home_path(df))
                %x[cp -r #{Dot.home_path(df)} #{Dot::Dir[:old]}]
                puts "Copied #{df} to backup folder"
            end
        end
    end
end

desc "Setup common python packages"
task :packages do
    %x[sudo easy_install pip]
    %x[sudo pip install -U -r requirements.txt]
end

desc "Remove dotfiles from HOME dir"
task :cleanup => [:backup, :clean_tmp] do
    Dot::All.each do |df|
        if File.exists?(Dot.home_path(df))
            puts Dot.red("Deleting #{df}...")
            %x[rm -rf #{Dot.home_path(df)}]
        end
    end
    # Remove vimwiki links and html dir
    if File.exists?(File.join(Dot::Dir[:home], 'vimwiki_html'))
        puts Dot.red("Deleting wiki rendered html folder...")
        %x[rm -r #{File.join(Dot::Dir[:home], 'vimwiki_html')}]
    end
    if File.exists?(File.join(Dot::Dir[:home], 'vimwiki'))
        puts Dot.red("Deleting wiki symlink...")
        %x[rm #{File.join(Dot::Dir[:home], 'vimwiki')}] 
    end
end
        
desc "Execute full build for current machine"
task :build => [:up, :update, :cmdt_build] do
end

desc "Setup vimwiki link"
task :wiki do
    if File.exists?(File.join(pwd,'..','wiki'))
        puts "Setting up vimwiki..."
        %x[ln -s #{File.join(pwd, '..', 'wiki')} #{Dot::Dir[:home] + '/vimwiki'}]
    end
end

desc "Build command-t ruby extension"
task :cmdt_build do
    puts "Building command-t..."
    cmdt_path = File.join(Dot::Dir[:bundle], 'command_t/ruby/command-t/')
    %x[cd #{cmdt_path}; ruby extconf.rb]
    # Default Makefile installs into site_ruby/ isntead of site_ruby/command-t, which
    # breaks the import.
    %x[sed -i "s/target_prefix = /target_prefix = \\/command-t/g" #{File.join(cmdt_path, 'Makefile')}]
    puts %x[cd #{cmdt_path}; make && sudo make install && make realclean]
    
end

