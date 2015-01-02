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

    # _stevenson.yml

    '_config.yml':
      title:
        type: 'text'
        prompt: 'Title: '
        limit: 40
      email:
        type: 'email'
        prompt: 'Email: '
      description:
        type: 'text'
        prompt: 'Description: '
      url:
        type: 'url'
        prompt: 'URL: '

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

    # _config.yml

    title: RootsRated.com
    email: info@rootsrated.com
    description: This is a microsite created by RootsRated.com
    url: http://www.rootsrated.com

The `prompt` attribute defines how the user should be prompted for input, the
`type` attribute specifies which kind of input the prompt should accept, and any
values already set in the `_config.yml` will be used as defaults for these
questions. Alternatively, defaults can be overriden with a `default` attribute.

### Input Types

There are several input types available now, and hopefully, there will be more
in the future.

#### Text

The most basic input is the text input. This simply accepts a text string.
Optionally, a limit can be added with the `limit` attribute.

#### Email

This input is a subclass of the text input that only accepts emails as validated
with the following regex: `/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i`.
Additionally, Email has the same options as Text.

#### Password

This input is also a subclass of text, but unlike text, it will not output the
input string to the console for added security.

#### Url

This input, another subclass of text, accepts only text that satisfies this
regex: `/https?:\/\/[\S]+/`.

#### Select

This input prompts the user to choose from a list of given options. The options
can be provided as subkeys to the `options` attribute like so:

    favorite_color:
      type: 'select'
      prompt: 'Favorite Color: '
      options:
        'Red': '#FF0000'
        'Blue': '#00FF00'
        'Green': '#0000FF'

The first value given is the value that will be offer to the user to choose. The
second value is the value that will be written to `_config.yml`.

Optionally, you can also fetch more options from a JSON API source using the
`url`, `list_key`, `name_key`, and `value_key` attributes. `url` specifies the
url to fetch json options from. `list_key` specifies the root element of the
JSON document to iterate over for options. `name_key` specifies the name from
each iterated item to use as a name. `value_key` specifies the value from each
iterated item to use as a value. The following example is identical to the
previous example using the `options` attribute:

    # http://someapi.com/source.json

    {
      "response": [
        {
            "name": "Red",
            "value": "#FF0000"
        },
        {
            "name": "Blue",
            "value": "#00FF00"
        },
        {
            "name": "Green",
            "value": "#0000FF"
        }
      ]
    }

    # _stevenson.yml

    favorite_color:
      type: 'select'
      prompt: 'Favorite Color: '
      url: 'http://someapi.com/source.json'
      list_key: 'response'
      name_key: 'name'
      value_key: 'value'

Additionally, remote sources and the `options` attribute can be used together.
If two keys collide between the two, the remote source will always override the
`options` attribute.

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
