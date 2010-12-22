require 'erb'

module Dot
    All = FileList['*'].exclude('Rakefile', "*.[^e]*")
    Build = All.map {|x| '.' + x.sub('.erb','')}
    System = `uname -s`.strip.downcase
    Home = Build.map{|x| File.join(ENV['HOME'], x)}
    Dir = {
        :build => File.join(pwd, 'build/', System),
        :old => File.join(ENV['HOME'], '.old/'),
        :home => ENV["HOME"],
    }

    def self.home_path(file)
        File.join(Dir[:home], ".#{file.sub('.erb','')}")
    end

    def self.build_path(file)
        File.join(Dir[:build], ".#{file.sub('.erb','')}")
    end

    def self.old_path(file)
        File.join(Dir[:old], ".#{file.sub('.erb','')}")
    end

    def self.file_parts(file)
         FileList["#{file.sub('.erb','')}.local.#{System}", "#{home_path(file)}.local"]
    end

    def self.update_from_build(file)
        if not File.exists?(build_path(file)) or File.directory?(home_path(file))
            touch home_path(file)
        else
            mv build_path(file), home_path(file)
        end
    end

    def self.build_file(file)
        parts = file_parts(file)
        # If directory, symlink to build/system
        if File.directory?(file):
            ln_s File.join(pwd, file), build_path(file) if not File.exists?(build_path(file))
            return
        end
        # If not changed, leave as is
        if uptodate?(build_path(file), parts.include(file)) or uptodate?(home_path(file), parts)
            return
        end
        # Else, delete old one
        rm_f build_path(file) # if File.exists?(build_file)
        puts "Building #{file}..."
        # If *.erb - render template
        if file =~ /.erb$/
            puts "Rendering #{file}..."
            File.open(build_path(file), 'w') do |render_file|
                render_file.write ERB.new(File.read(file)).result(binding)
            end
        # Else copy base
        else
            cp file, build_path(file)
        end
        # Append file.local parts
        file_parts(file).each do |part|
            puts "Appending #{part} to #{file}"
            system "cat #{part} >> #{build_path(file)}" if File.exists?(part)
        end
    end
end

task :default do
    puts Dot::All
    puts Dot.file_parts('zshrc')
end

desc "Setup common python packages"
task :packages do
    system 'sudo easy_install pip'
    system 'sudo pip install -U -r requirements.txt'
end

desc "Setup vimwiki link"
task :wiki
# TODO setup vimwiki link

desc "Update pathogen and sumbodules"
task :update do
    # TODO pathogen update,
    update = `git submodule foreach git pull origin master`
    puts `git status`
end

desc "Install dotfiles"
task :install => [:cleanup, :up]

desc "Quick rebuild"
task :up => [:build] do
    #  TODO submodule init, submodule update
    Dot::All.each do |file|
        Dot.update_from_build file
    end
    rm_r Dot::Dir[:build]
end

desc "Remove symlinks and restore files from .old"
task :remove => [:cleanup] do
    if File.exists?(Dot::Dir[:old])
        Dot::All.each do |df|
             mv Dot.old_path(df), Dot::Dir[:home] if File.exist?(Dot.old_path(df))
        end
        rm_r Dot::Dir[:old]
    end
end

desc "Backup existing config to .old folder"
task :backup do
    if not File.exists?(Dot::Dir[:old])
        mkdir Dot::Dir[:old]
        Dot::All.each do |df|
            cp_r Dot.home_path(df), Dot::Dir[:old] if File.exist?(Dot.home_path(df))
        end
    end
end

desc "Remove dotfiles from HOME dir"
task :cleanup => [:backup] do
    rm_r Dot::Dir[:build] if File.exists?(Dot::Dir[:build])
    # TODO Delete wiki link and rendered folder
    Dot::All.each do |df|
        rm_rf Dot.home_path df 
    end
end
        
desc "Create build dir for current machine"
task :build do
    mkpath Dot::Dir[:build] if not File.exists?(Dot::Dir[:build])
    Dot::All.each do |df|
        Dot.build_file df
    end
    # TODO build command-t, move ext.so to RUBY dir rubylib/command-t/
end

