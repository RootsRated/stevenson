# Stevenson
[![Build Status](https://travis-ci.org/RootsRated/stevenson.png)](https://travis-ci.org/RootsRated/stevenson)
[![Gem Version](https://badge.fury.io/rb/stevenson.svg)](http://badge.fury.io/rb/stevenson)
[![Code Climate](https://codeclimate.com/github/RootsRated/stevenson/badges/gpa.svg)](https://codeclimate.com/github/RootsRated/stevenson)
[![Test Coverage](https://codeclimate.com/github/RootsRated/stevenson/badges/coverage.svg)](https://codeclimate.com/github/RootsRated/stevenson/coverage)

Stevenson is a [Jekyll](http://jekyllrb.com) microsite generator created by
RootsRated.com. Stevenson is named for Robert Louis Stevenson, author of *The
Strange Case of Dr. Jekyll and Mr. Hyde*.
[A project](https://github.com/dirk/stevenson) was previously created with this
name and a similar purpose about 2 years ago, but it hasn't been updated since.
This project is our attempt to resurrect the idea of a quick simple Jekyll site
generator.

## Installation

Add this line to your application's Gemfile:

    gem 'stevenson'

And then execute:

    $ bundle

Or install it globally:

    $ gem install stevenson

## Usage

### Basics

Use Stevenson to create a new microsite like this:

    $ stevenson new hello_world

This will create a new directory in your current working directory named
`hello_world`. This directory should be a ready-to-use Jekyll
installation.

### Templates

By default, stevenson will use RootsRated's
[Hyde](https://github.com/rootsrated/hyde) repo as the template for the new
site, but alternative templates can be used with the `--template` or `-t`
option, like so:

    $ stevenson new hello_world -t https://github.com/YourUsername/YourTemplate.git

This will clone the repo at `https://github.com/YourUsername/YourTemplate.git`
to `hello_world`.

### Private Git Templates

If you'd like to use a template in a private git repo, you can pass GitHub credentials or store them in ENV variables. This will take priority over the 'template' option above.

    $ stevenson new hello_world --private_template https://github.com/YourUsername/YourTemplate.git bob 123

This will clone the repo at `https://github.com/YourUsername/YourTemplate.git`
to `hello_world`.

Additionally, Stevenson can use the `GITHUB_SERVICE_ACCOUNT_USERNAME` and
`GITHUB_SERVICE_ACCOUNT_PASSWORD` environment variables.

### Zip Output

Stevenson can output directories as a zip archive using the `-z` or `--zip`
flags. The following command will produce a zipped version of the first
example's result:

    $ stevenson new hello_world.zip -z

This will output a file called `hello_world.zip` with a ready-built website.

### S3 Deploy

Stevenson can deploy projects to S3 using the `--s3` flag. The following
command will deploy the resulting output to S3:

    $ stevenson new hello_world.zip --s3=bucket file_key AWS_KEY AWS_SECRET

Additionally, Stevenson can use the `AWS_ACCESS_KEY_ID` and
`AWS_SECRET_ACCESS_KEY` environment variables.

## Similar Projects

Stevenson may not be the right tool for what you're trying to do, so here's a few
other projects with similar ideas but slight differences:

- [Octopress](http://octopress.org/) - Octopress is a build and management tool
for jekyll sites that's more targeted at blogging and personal sites than
microsites. Octopress is a much more complete solution for jekyll sites with a
much bigger community, however it definitely lacks some of the simplicity and
ease of Stevenson. If Stevenson is Sinatra, Octopress is Ruby on Rails.
- [The Original Stevenson Project](https://github.com/dirk/stevenson) - This
project was not a first. There was another project called Stevenson with a similar
idea a while back, but unfortunately it hasn't been updated in over 2 years.

## Contributing

1. Fork it ( https://github.com/RootsRated/stevenson/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Contributors

- [Dylan Karr](https://github.com/dylankarr)
- [Scott BonAmi](http://github.com/sbonami)

Don't forget to check out other open-source projects from [RootsRated](http://github.com/RootsRated)!
