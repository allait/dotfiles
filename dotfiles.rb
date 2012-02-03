require 'erb'

STRIP_EXTENSIONS = /\.erb/

def components
  Dir.glob('*/').map do |component|
    component.split("/").last
  end
end

def linkables(component)
  Dir.glob("#{component}/*").reject do |item|
    item =~ /Rakefile|build|\.local|\.remote/
  end
end

def install(components, type)
  `mkdir -p $HOME/.backup/` if not File.directory?("#{ENV["HOME"]}/.backup")
  `mkdir -p $HOME/tmp/{swap,backup,undo}`
  components.each do |component|
    if Rake::Task.task_defined? "#{component}:install"
      Rake::Task["#{component}:install"].invoke
    else
      linkables(component).each do |linkable|
        install_item(linkable, nil, type)
      end
    end
  end
end

def install_item(item, target=nil, type=:local)
  file = item.split('/').last.split(STRIP_EXTENSIONS).last
  target = target || "#{ENV["HOME"]}/.#{file}"
  backup_target = "#{ENV["HOME"]}/.backup/.#{file}"

  if File.exists?(target) || File.symlink?(target)
    if not File.exists?(backup_target)
      `mv "$HOME/.#{file}" "#{backup_target}"`
    else
      FileUtils.rm_rf(target)
    end
  end
  link_item(item, target, type)
end

def link_item(item, target, type)
  system_name = `uname -s`.strip.downcase
  parts = Dir.glob("#{item.split(STRIP_EXTENSIONS).last}.#{type}{.#{system_name},}")

  puts "Linking #{target}..."
  return `ln -s $PWD/#{item} #{target}` if File.directory?(item)

  if item =~ /.erb$/
      File.open("#{target}", 'w') do |render_file|
          render_file.write ERB.new(File.read(item)).result(binding)
      end
  elsif parts.empty?
      `ln -s $PWD/#{item} #{target}`
  else
      `cp $PWD/#{item} #{target}`
  end

  parts.each do |part|
      puts "Appending #{part} to #{item}..."
      `cat #{part} >> #{target}`
  end
end

def uninstall_item(item)
    file = item.split('/').last.split(STRIP_EXTENSIONS).last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target)
      FileUtils.rm(target)
    end

    # Restore any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.backup/.#{file}")
      `mv "$HOME/.backup/.#{file}" "$HOME/.#{file}"`
    end
end
