require "active_support/all"
require "git"
require "stevenson/version"

module Stevenson
  HYDE_URL = 'https://github.com/dylankarr/textNooga.git'

  class Console
    def create(project_name)
      directory_name = project_name.underscore
      Git::Base.clone HYDE_URL, directory_name
    end
  end
end
