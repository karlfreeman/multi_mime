# MultiMime ( WIP )
[![Gem Version](https://badge.fury.io/rb/multi_mime.png)][gem]
[![Build Status](https://secure.travis-ci.org/karlfreeman/multi_mime.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/karlfreeman/multi_mime.png?travis)][gemnasium]
[![Code Climate](https://codeclimate.com/github/karlfreeman/multi_mime.png)][codeclimate]

[gem]: https://rubygems.org/gems/multi_mime
[travis]: http://travis-ci.org/karlfreeman/multi_mime
[gemnasium]: https://gemnasium.com/karlfreeman/multi_mime
[codeclimate]: https://codeclimate.com/github/karlfreeman/multi_mime

A generic swappable back-end for Mime Type detection

## Usage Examples
Lots of Ruby libraries utilize Mime Type detection in some form. In order to best support multiple Mime Type detection and
libraries, `multi_mime` is a general-purpose swappable Mime Type detection backend library. You
use it like so:

```ruby
require 'multi_mime'
```

## Supported Mime Engines

* [Mime::Type](http://api.rubyonrails.org/classes/Mime/Type.html) Rails Mime Type
* [Rack::Mime](http://rack.rubyforge.org/doc/Rack/Mime.html) Rack Mime Type
* [MIME::Types](https://github.com/halostatue/mime-types) MIME::Types for Ruby

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0
* [JRuby][]
* [Rubinius][]
* [MacRuby][] (not tested on Travis CI)

[jruby]: http://www.jruby.org/
[rubinius]: http://rubini.us/
[macruby]: http://www.macruby.org/


# Credits

Inspiration:

- [MultiJSON](https://github.com/intridea/multi_json)
- [MultiXML](https://github.com/sferik/multi_xml)

Cribbed:

- [MultiJSON](https://github.com/intridea/multi_json)
- [Asset_Sync's MultiMime module](https://github.com/rumblelabs/asset_sync/commit/9333bd01ae1a7cf2ffa046b8390fbc4165c38030)