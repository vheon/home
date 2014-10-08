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
task :vim do
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
  sh ".osx"

def abs_path file
  File.expand_path(file)
end
