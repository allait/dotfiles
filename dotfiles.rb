require 'erb'

STRIP_EXTENSIONS = /\.erb/

def components
  return ENV["components"].split(",") if ENV["components"]
  Dir.glob('*/').map do |component|
    component.split("/").last
  end
end

def linkables(component)
  Dir.glob("#{component}/*").reject do |item|
    item =~ /Rakefile|build|\.local|\.remote/
  end
end

def remote?
  ENV["remote"]
end

def install_item(item, target=nil)
  file = item.split('/').last.split(STRIP_EXTENSIONS).last
  target = target || "#{ENV["HOME"]}/.#{file}"
  backup_target = "#{ENV["HOME"]}/.backup/.#{file}"

  if File.exists?(target) || File.symlink?(target)
    if not File.exists?(backup_target)
      `mkdir -p $HOME/.backup/` if not File.directory?("#{ENV["HOME"]}/.backup")
      `mv "$HOME/.#{file}" "#{backup_target}"`
    else
      FileUtils.rm_rf(target)
    end
  end
  link_item(item, target)
end

def link_item(item, target)
  if remote?
    system_name = ENV["remote"]
    parts = Dir.glob("#{item.split(STRIP_EXTENSIONS).last}.remote{.#{system_name},}")
    cmd = "cp -rf"
    puts "Copying #{target}..."
  else
    system_name = `uname -s`.strip.downcase
    parts = Dir.glob("#{item.split(STRIP_EXTENSIONS).last}.local{.#{system_name},}")
    cmd = "ln -s"
    puts "Linking #{target}..."
  end

  return `#{cmd} $PWD/#{item} #{target}` if File.directory?(item)

  if item =~ /.erb$/
      File.open("#{target}", 'w') do |render_file|
          render_file.write ERB.new(File.read(item)).result(binding)
      end
  elsif parts.empty?
      `#{cmd} $PWD/#{item} #{target}`
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
      puts "Removing #{target}..."
      FileUtils.rm_rf(target)
    end

    # Restore any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.backup/.#{file}")
      `mv "$HOME/.backup/.#{file}" "$HOME/.#{file}"`
    end
end
