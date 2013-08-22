import vim

def FlagsForFile(filename):
  filetype = vim.eval('&filetype')

  if filetype == 'c':
    flags = ['-xc', '-Wall', '-Wextra', '-pedantic']
  elif filetype == 'cpp':
    flags = ['-xc++', '-Wall', '-Wextra', '-pedantic']
  elif filetype == 'objc':
    flags = ['-ObjC', '-Wall', '-Wextra', '-pedantic']
  else:
    flags = []

  return {
    'flags':    flags,
    'do_cache': True
  }
