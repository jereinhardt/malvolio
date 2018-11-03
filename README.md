# Malvolio

Malvolio is a CLI tool that creates an easy workflow when developing HTML emails.

## Installation

In your terminal, install the gem from Rubygems.

```
gem install malvolio
```

## Usage

To create a new project, run the command

```
malvolio new <project-name> [--inky]
```

the `--inky` option will create a project that allows you to use The [Zurb Foundation's Inky Templating Language](https://foundation.zurb.com/emails/docs/inky.html) and comes bundled with their (Foundation Email CSS Framework)[https://foundation.zurb.com/emails.html].

The `new` command will generate a new project with the following structure:

```
/project-name
  ├──tmp/
  ├──dist/
  └──src/
      ├──index.html
      └──scss/
          └──index.scss
```

Once you've done some work in the `src/` directory and are ready to build, you can run

```
malvolio build [PROJECT PATH] [--no-warnings]
```

Or, if you would like for your project to build automatically as you go, you can run

```
malvolio watch [PROJECT PATH] [--no-warnings]
```

Running either of these commands will output your final HTML email file to `dist/index.html`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jereinhardt/malvolio.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
