require 'git'
require 'tmpdir'

module Stevenson
  module TemplateLoaders
    class GitLoader
      def initialize(template_url)
        @template_url = template_url
      end

      def load
        dir = Dir.mktmpdir
        Git::Base.clone @template_url, "#{dir}/repo"
        "#{dir}/repo"
      end
    end
  end
end
