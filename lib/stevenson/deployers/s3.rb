require 'fog'

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
        Dir.glob("#{directory}/**/*").each do |file|
          s3_bucket.files.create(
            key:    File.join(deployment_key, file.partition(directory).last),
            body:   File.read(file),
            public: true,
          ) if File.file?(file)
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
