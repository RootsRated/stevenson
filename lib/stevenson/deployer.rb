module Stevenson
  module Deployer
    module Base
      attr_reader :options

      def self.included(deployer)
        deployer.extend ClassMethods

        Stevenson.deployers[deployer.deployer_name] = deployer
      end

      module ClassMethods
        def deployer_name
          name.gsub(/^.*::/, '').downcase.to_sym
        end
      end

      def initialize(options)
        @options = options
      end

      def deploy!(directory)
        raise NotImplementedError
      end
    end

    class << self
      def deploy(directory, options)
        deployers_for(options).each do |deployer|
          deployer.new(options).deploy!(directory)
        end
      end

      private

      def deployers_for(options)
        [].tap do |deployers|
        end
      end

      def deployer_for(type)
        Stevenson.deployers.fetch(type, nil) || const_get(type.to_s.capitalize)
      rescue NameError
        raise InvalidDeployerException.new "Type '#{type}' is not a valid deployer."
      end
    end

    class InvalidDeployerException < StandardError; end
  end
end
