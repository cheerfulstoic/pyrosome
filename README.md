# Pyrosome

![Pyrosome Rider](pyrosome_ride.jpg)

Photo via [Mr Roger Fenwick](http://www.biodiversityexplorer.org/mm/tunicates/pyrostremma_spinosum.htm)

"Pyrosomes, genus Pyrosoma, are free-floating colonial tunicates that live usually in the upper layers of the open ocean in warm seas, although some may be found at greater depths. Pyrosomes are cylindrical- or conical-shaped colonies made up of hundreds to thousands of individuals, known as zooids. Colonies range in size from less than one centimeter to several metres in length."

Like Pyrosomes, files are made up of many individual pieces.  The UNIX philosophy encorages operating on streams of data and Ruby embraces this in part with command line options such as `-n` and `-e` so that you can process a stream of data by specifying a Ruby script from the command line which works with a single piece of a file.  This gem aims to provide the same functionality for more complex datasets such as JSON, CSV, XLS, etc...

Inspired by [Ruby Rogues, Episode 235: Processing Textual Data with Ruby with Rob Miller](https://devchat.tv/ruby-rogues/235-rr-processing-textual-data-with-ruby-with-rob-miller)

If you like this project you should also check out the excellent [csvkit](https://csvkit.readthedocs.org) toolkit from ThoughtBot.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/pyrosome`. To experiment with that code, run `bin/console` for an interactive prompt.


**NOTICE:** This is still under development!

## Installation

Install the gem:

    $ gem install pyrosome

## Usage

The command to execute is `psome` (pronounced `p-some`, ryhmes with `roam`).  It takes a stream like this:

    cat file.csv | psome -i csv -e "puts _[0]"

You can see that we specify the format that is expected and a bit of Ruby code which exects to use a `_` variable

### Arguments

#### -i [FORMAT] / --input [FORMAT]

Specify a input.  `json` and `csv` currently supported

#### -e [CODE] / --exec [CODE]

Give some Ruby code to be executed.  A `_` variable will be in scope and will represent the object which is retrieved for each iteration

#### -h / --headers

If the data is tabular, should we expect headers?

#### -f / --forks [FORK_COUNT]

Specify that parallel processing is used via separate processes and specify how many processes to use

#### -t / --threads [THREAD_COUNT]

Specify that parallel processing is used via separate threads and specify how many threads to use

### Methods

#### ``sync``

If you are running in parallel mode you can call the `sync` method within your code to run part of it synchronously.  This is particularly useful for having multiple threads/processes coordinate to write output, even if you don't care what order they do it in.  If you specify that threads are to be used then the Ruby `Mutex` will do the synchronization, while for forks a temporary file with be created to `flock` to.

**Example:**

# Convert CSV to JSON:

some_unix_commands | psome -f4 -i csv -e "name, age = _[0], _[1].to_i; sync { puts({name: name, age: age}.to_json + ',') }"

## TODOs

By default process lines like Ruby (so that people can use `psome` for everything without switching back and forth and so that they can take advantage of parallel processing and any other convenience features)

-i to do in place replacement of files

Support file names as arguments.

Support file name for code execution instead of -e?  Could files have both `_` and `ARGV` in scope so that scripts not made for pyrosome be used?

Flag to echo sample of what you would get with the specified options (do I get an array or a hash?  Does the hash have keys?)

Support for colors?

Support for different enumerators?  Sort_by comes to mind, but that wouldn't work for streaming (or would it?). Select/reject.  Does any?/all? make sense?

Support for loading an app environment (automatically load Rails if inside a project to get models?)

Easy generation of CSV / JSON from Ruby data?

Some way to load libraries?

Refer to https://robm.me.uk/ruby/2015/10/31/dollar-underscore.html

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pyrosome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

