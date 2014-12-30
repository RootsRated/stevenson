# Stevenson
[![Build Status](https://travis-ci.org/RootsRated/stevenson.png)](https://travis-ci.org/RootsRated/stevenson)

Stevenson is a [Jekyll](http://jekyllrb.com) microsite generator created by
RootsRated.com. Stevenson is named for Robert Louis Stevenson, author of *The
Strange Case of Dr. Jekyll and Mr. Hyde*.
[A project](https://github.com/dirk/stevenson) was previously created with this
name and a similar purpose about 2 years ago, but it hasn't been updated since.
This project is our attempt to resurrect the idea of a quick simple Jekyll site
generator.

## Installation

Add this line to your application's Gemfile:

    gem 'stevenson', :git => 'git://github.com/RootsRated/stevenson.git'

And then execute:

    $ bundle

Or install it yourself with:

    $ git clone git://github.com/RootsRated/stevenson.git
    $ cd stevenson
    $ rake install

## Usage

### Basics

Use Stevenson to create a new microsite like this:

    $ stevenson new hello_world

This will create a new directory in your current working directory named
`hello_world`. This directory should be a ready-to-use Jekyll
installation.

### Jekyll Compiling

Stevenson can automatically jekyll build a project and output a built directory
using the `-j` or `--jekyll`. Following the example from above, you can use the
following command:

    $ stevenson new hello_world -j

This will output a directory called `hello_world` with the built assets from the
jekyll project created by the earlier command without the jekyll flag.

### Zip Output

Stevenson can also output directories as a zip archive using the `-z` or `--zip`
flags. The following command will produce the same result as the first example
as a zip archive:

    $ stevenson new hello_world.zip -z

Also, the zip flag and jekyll flag can be used together to produce a built and
compress out like so:

    $ stevenson new hello_world.zip -z -j

This will output a file called `hello_world.zip` with a ready-built website.

Remember that the first argument to `stevenson new` should have a `.zip` on the
end, as stevenson will not automatically add this extension.

### Templates

By default, stevenson will use RootsRated's
[Hyde](https://github.com/rootsrated/hyde) repo as the template for the new
site, but alternative templates can be used with the `--template` or `-t`
option, like so:

    $ stevenson new hello_world -t https://github.com/YourUsername/YourTemplate.git

This will clone the repo at `https://github.com/YourUsername/YourTemplate.git`
to `hello_world` and begin altering the repo based on the contents of a
YAML file in your template's root directory named `_stevenson.yml`. This file
should contain config options to be set in various files of your Jekyll
installation along with information on whether these options should be secret,
validated as emails, validated as URLs, or limited to a certain length.

Here's an example of the YAML file:

    #_stevenson.yml
    '_config.yml':
      title:
        question: 'Title: '
       limit: 40
      email:
        question: 'Email: '
        email: true
      description:
        question: 'Description: '
      url:
        question: 'URL: '
        url: true

This file will produce the following questions when
`stevenson new hello_world https://github.com/YourUsername/YourTemplate.git` is
used:

    $ stevenson new hello_world -t https://github.com/YourUsername/YourTemplate.git
    Title: My Site
    Email: info@example.org
    Description: Lorem Ipsum...
    URL: http://www.example.org

When these questions are answered, the following will be added to
`hello_world/_config.yml`:

    #_config.yml
    title: RootsRated.com
    email: info@rootsrated.com
    description: This is a microsite created by RootsRated.com
    url: http://www.rootsrated.com

**The 'question' of each option is required** and will be used to ask users for
input to replace these values.

Any values already set in the `_config.yml` will be used as defaults for these
questions.

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
