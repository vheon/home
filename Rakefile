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

desc "Set up golang"
task :golang => :brewfile do
  mkdir_p abs_path('~/code/go')
end

# XXX(vheon): add a task to configure fish automatically

def abs_path file
  File.expand_path(file)
end
