require 'fog/aws'

module Stevenson
  module Deployer
    class S3
      include Deployer::Base

      attr_reader :deployment_bucket_name, :deployment_key

      def initialize(options)
        @deployment_bucket_name, @deployment_key, @deployment_access_key, @deployment_access_secret = options["s3"]
        super
      end

      def deploy!(directory)
        entries_for(directory).each do |file_path, file_name|
          s3_bucket.files.create(
            key:    File.join(deployment_key, file_name),
            body:   File.read(file_path),
            public: true,
          ) if File.file?(file_path)
        end
      end

      def entries_for(directory)
        if File.file?(directory)
          [
            [directory, File.basename(directory)]
          ]
        else
          Dir.glob("#{directory}/**/*").collect { |f| [f, f.partition(directory).last] }
        end
      end

      private

      def fog
        @_fog ||= Fog::Storage.new(
          provider:              'AWS',
          aws_access_key_id:     @deployment_access_key || ENV["AWS_ACCESS_KEY_ID"],
          aws_secret_access_key: @deployment_access_secret || ENV["AWS_SECRET_ACCESS_KEY"],
        )
      end

      def s3_bucket
        @_s3_bucket = fog.directories.new(key: deployment_bucket_name)
      end
    end
  end
end
