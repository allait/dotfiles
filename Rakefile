require 'erb'

module Dotfiles
    All = FileList['*'].exclude('Rakefile', '*.*')
    Home = All.map {|x| File.join(ENV['HOME'], '.' + x)}
    System = `uname -s`.strip.downcase
end

task :default do
    puts Dotfiles::Home
end

desc "Setup common python packages"
task :install_packages
# TODO setup pip, ipython and whatnot

desc "Setup vimwiki link"
task :wiki
# TODO setup vimwiki link

desc "Update pathogen and sumbodules"
task :update do
    # TODO pathogen update, submodule init, submodule update
    update = `git submodule foreach git pull origin master`
    status = `git status`
    puts status
end

desc "Install dotfiles"
task :install => [:symlink]

desc "Remove dotfiles"
task :remove => [:restore]

desc "Backup existing config to .old folder"
task :backup do
    old_dir = File.join(ENV['HOME'], '.old/')
    if not File.exists?(old_dir)
        mkdir old_dir
        Dotfiles::Home.each do |df|
            cp_r df, old_dir if File.exist?(df)
        end
    end
end

desc "Remove dotfiles from HOME dir"
task :delete => [:backup] do
    rm_r build_dir if File.exists?(build_dir)
    Dotfiles::Home.each do |df|
        rm_r df if File.exists?(df) or File.symlink?(df)
    end
end

desc "Create symlinks in $HOME"
task :symlink => [:delete, :build] do
    Dotfiles::All.each do |df|
        if not File.directory?(df)
            ln_s File.join(build_dir, df), Dotfiles::Home[Dotfiles::All.index(df)]
        else
            ln_s File.join(pwd, df), Dotfiles::Home[Dotfiles::All.index(df)]
        end
    end
end

def build_dir
    File.join(pwd, 'build/', Dotfiles::System)
end

desc "Create build dir for current machine"
# TODO Regenerate files if not uptodate
task :build do
    rm_r build_dir if File.exists?(build_dir)
    mkpath build_dir
    Dotfiles::All.each do |df|
        if not File.directory?(df)
            FileList['%s{,.%s}' % [df, Dotfiles::System]].each do |kf|
                `cat #{kf} >> #{File.join(build_dir, df)}`
            end
        end 
    end
    # TODO build command-t, move ext.so to RUBY dir rubylib/command-t/
end


desc "Remove symlinks and restore files from .old"
task :restore => [:delete] do
    old_dir = File.join(ENV['HOME'], '.old/')
    if File.exists?(old_dir)
        Dotfiles::All.each do |df|
             mv File.join(old_dir, df), ENV['HOME'] if File.exist?(File.join(old_dir, df))
        end
        rm_r old_dir
    end
end
