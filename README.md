# Stevenson

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

Use Stevenson to create a new microsite like this:

    $ stevenson NameOfYourSite

This will create a new directory in your current working directory named
`name_of_your_site`. This directory should be a ready-to-use Jekyll
installation.

By default, stevenson will use RootsRated's
[Hyde](https://github.com/rootsrated/hyde) repo as the template for the new
site, but alternative templates can be used by passing a second argument to
`stevenson`, like so:

    $ stevenson NameOfYourSite https://github.com/YourUsername/YourTemplate.git

This will clone the repo at `https://github.com/YourUsername/YourTemplate.git`
to `name_of_your_site` and begin altering the repo based on the contents of a
YAML file in your template's root directory named `_stevenson.yml`,
`.stevenson.yml` or `.stevenson`. This file should contain config options to be
set in the `_config.yml` of your Jekyll installation along with information on
whether these options should be secret, validated as emails, validated as URLs,
or limited to a certain length.

Here's an example of the YAML file:

    #_stevenson.yml
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
`stevenson NameOfYourSite https://github.com/YourUsername/YourTemplate.git` is
used:

    $ stevenson NameOfYourSite https://github.com/YourUsername/YourTemplate.git
    Title: My Site
    Email: info@example.org
    Description: Lorem Ipsum...
    URL: http://www.example.org

When these questions are answered, the following will be added to
`name_of_your_site/_config.yml`:

    #_config.yml
    title: RootsRated.com
    email: info@rootsrated.com
    description: This is a microsite created by RootsRated.com
    url: http://www.rootsrated.com

**The 'question' of each option is required** and will be used to ask users for
input to replace these values.

Any values already set in the `_config.yml` will be used as defaults for these
questions.

## Contributing

1. Fork it ( https://github.com/RootsRated/stevenson/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
