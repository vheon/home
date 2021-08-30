def github_url(repo, ci = False):
  if not ci:
    return "git@github.com:"+repo+".git"

  return "https://github.com/"+repo+".git"

class FilterModule(object):
  def filters(self):
    return {
      'github_url': github_url
    }
