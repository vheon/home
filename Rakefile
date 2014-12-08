require 'rake'

desc "Install Homebrew."
task :homebrew do
  if File.exists? '/usr/local/bin/brew'
    puts "** Homebrew already installed. **"
  else
    puts "\n**** Installing Homebrew ****"
    system 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  end
end

desc "Bootstrap vim"
task :vim => [:brewfile, :extra_tools] do
  if not Dir['.vim/bundle/*'].empty?
    puts "** Vim plugins already installed. **"
  else
    puts "\n**** Installing Vim plugins ****"
    system 'vim +PlugInstall +qall'
  end
end

desc "Install from Brewfile"
task :brewfile => :homebrew do
  sh abs_path('Brewfile')
end

desc "Setup Mac OS X defaults"
task :osx do
  sh abs_path('.osx')
end

desc "Link config file to non home locations"
task :config_files => :homebrew do
  ln_sf abs_path('~/etc/Karabiner/private.xml'), abs_path('~/Library/Application Support/Karabiner/private.xml')
end

desc "Set up golang"
task :golang => brewfile do
  mkdir_p abs_path('~/code/go')
end

desc "Install extra tools needed"
task :extra_tools => :golang do
  sh 'go get github.com/mattn/files'
  sh 'go get github.com/vheon/picker'
end

def abs_path file
  File.expand_path(file)
end
