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
  File.foreach('Brewfile') do |line|
    unless line.chomp.empty? || line =~ /\A\s*#/
      sh "brew #{line}"
    end
  end
end

desc "Setup Mac OS X defaults"
task :osx do
  sh ".osx"
end
