# GlueGun

A tool for connecting parts of your application at configuration time.

## But why?

This is part thought experiment, as I wanted to explore pluginable builders.
This is perhaps needed for working with lots of potentially inter-related Rails engines; Thank you [Project Hydra](https://projecthydra.org).

## Why might this be helpful?

Given that you have an application that is based on a Rails engine or multiple Rails engines.
When you want to decorate the behavior of one of the engines
...And don't want to fork the repository
...And don't have an easy means of submitting a pull request
Then you may need Glue Gun

## How to think about this?

Imagine that you want Rails to report each and every time an action in one of the engines is called.
Because of Ruby you can do it relatively easily; Classes can be reopened.
However, is it critical that you application do the reporting?
Should you always have that overhead in your tests?

My hope is that with GlueGun you can declare how your various pieces interact together.
By declaring those interactions, you also have a chance to greater isolate your tests.
And by that, I mean in the future I intend for GlueGun to be disabled for your tests, unless you specifically want the test to enable all of the hot glue.

## Installation

Add this line to your application's Gemfile:

    gem 'glue_gun'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glue_gun

## Usage

    $before = []
    $after = []

    class Book
      def read; end
    end

    GlueGun do |config|
      config.after_method(Book, :read) << lambda { |object|
        $before << object
      }

      config.after_method(Book, :read) << lambda { |object|
        $after << [:read,object]
      }
    end

    GlueGun.configure!

    book = Book.new
    book.read
    $before == [book]
    $after == [[:read, book]]

## Todo

* Document the plugin architecture.
* Create a rails generator for a new before_method hook
* Create a rails generator for a new after_method hook
* Create a command for controllers. In theory, after method is adequate for controllers if you always check the status. However, there may be more domain specific details for controller actions.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
