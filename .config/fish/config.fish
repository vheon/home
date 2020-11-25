set -x fish_greeting ''
set -x fish_term24bit 1

function a
  ls -lrth -G $argv
end

function ll
  ls -lh -G $argv
end

function take --description 'create a directory and cd into it'
  mkdir -p $argv[1]; and cd $argv[1]
end

function cdf --description 'cd into whatever is the forefront Finder window.'
  cd (osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')
end
