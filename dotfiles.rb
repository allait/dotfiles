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

  backup target
  link_item item, target
end

def backup(target)
  backup_target = "#{ENV["HOME"]}/.backup/#{target.split('/').last}"
  if File.exists?(target) && !File.symlink?(target)
    if not File.exists?(backup_target)
      `mkdir -p $HOME/.backup/` if not File.directory?("#{ENV["HOME"]}/.backup")
      `mv "#{target}" "#{backup_target}"`
    else
      FileUtils.rm_rf(target)
    end
  end
end

def link_item(item, target)
  type = (remote?)? "remote":"local"
  system_name = ENV["remote"] || `uname -s`.strip.downcase
  parts = Dir.glob("#{item.split(STRIP_EXTENSIONS).last}.#{type}{.#{system_name},}{.erb,}")
  cmd = (remote?)? "cp -rf":"ln -s"

  puts "#{cmd} #{target}..."

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
    if part =~ /.erb/
      File.open("#{target}", 'a') do |render_file|
        render_file.write ERB.new(File.read(part)).result(binding)
      end
    else
      `cat #{part} >> #{target}`
    end
  end
end

def uninstall_item(item, target=nil)
  file = item.split('/').last.split(STRIP_EXTENSIONS).last
  target = target || "#{ENV["HOME"]}/.#{file}"

  if File.exists?(target)
    puts "Removing #{target}..."
    FileUtils.rm_rf(target)
  end

  restore target
end

def restore(target)
  backup_target = "#{ENV["HOME"]}/.backup/#{target.split('/').last}"

  if File.exists?(backup_target)
    FileUtils.rm_rf(target) if File.exists?(target)
    `mv "#{backup_target}" "#{target}"`
  end
end
