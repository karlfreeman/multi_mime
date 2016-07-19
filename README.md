# MultiMime

A generic swappable back-end for MIME type detection

Lots of ruby libraries utilize MIME type detection in some form. In order to best support multiple MIME type detection libraries, `multi_mime` is a general-purpose, swappable, MIME type detection backend library.

eg [MultiJson](https://github.com/intridea/multi_json) for MIME types.

## Installation

```ruby
gem 'multi_mime', '~> 1.1'
```

```ruby
require 'multi_mime'
```

## Features / Usage Examples

Part of utilizing various MIME type libraries is the need for a common interface. `MultiMime` provides just that with following methods.

```ruby
MultiMime.type_for('text/html') # 'text/html'
# alias :by_type

MultiMime.type_for_extension('.html') # 'text/html'
# alias :by_extension

MultiMime.type_for_path('/usr/local/foo/bar/foo.html') # 'text/html'
# alias :by_path

MultiMime.type_for_file(File.open('foo.html', 'w')) # 'text/html'
# alias :by_file
```

`MultiMime` tries to have intelligent defaulting. That is, if you have any of the supported engines already loaded, it will utilize them before attempting to load any. When loading, libraries are ordered in the same order as [Supported Mime Engines](https://github.com/karlfreeman/multi_mime#supported-mime-engines). Lets try using `MultiMime` with `Rack::Mime` loaded, then switch it to `MIME::Types`.

```ruby
require 'rack/mime' # true

MultiMime.default_adapter # ':rack_mime'

MultiMime.adapter # MultiMime::Adapters::RackMime

MultiMime.reset_adapter # MultiMime::Adapters::RackMime

MultiMime.adapter = :mime_types # `:mime_types`

require 'mime/types' # false (eg loaded)

MultiMime.adapter # MultiMime::Adapters::MimeTypes

MultiMime.type_for_extension('.json') # 'application/json'
```

When MultiMime fails to load the specified adapter, it'll throw `MultiMime::AdapterError` which inherits from `ArgumentError`.

## Badges

[![Gem Version](http://img.shields.io/gem/v/multi_mime.svg)][gem]
[![Build Status](http://img.shields.io/travis/karlfreeman/multi_mime.svg)][travis]
[![Code Quality](http://img.shields.io/codeclimate/github/karlfreeman/multi_mime.svg)][codeclimate]
[![Code Coverage](http://img.shields.io/codeclimate/coverage/github/karlfreeman/multi_mime.svg)][codeclimate]
[![Gittip](http://img.shields.io/gittip/karlfreeman.svg)][gittip]

## Supported MIME Engines

* [MIME::Types](https://github.com/halostatue/mime-types)
* [MagicMime](https://github.com/minad/mimemagic)
* [Rails](http://api.rubyonrails.org/classes/Mime/Type.html) (ActionDispatch::Http::Mime)
* [Rack](http://rack.rubyforge.org/doc/Rack/Mime.html) (Rack::Mime)

## Supported Ruby Versions

This library aims to support and is [tested against][travis] the following Ruby
implementations:

- Ruby 2.3.0
- Ruby 2.2.0
- Ruby 2.1.0
- Ruby 2.0.0
- Ruby 1.9.3
- [JRuby][jruby]
- [Rubinius][rubinius]

# Credits

Inspiration:

- [MultiJSON](https://github.com/intridea/multi_json)
- [MultiXML](https://github.com/sferik/multi_xml)

Cribbed:

- [MultiJSON](https://github.com/intridea/multi_json)
- [Asset_Sync's MultiMime module](https://github.com/rumblelabs/asset_sync/commit/9333bd01ae1a7cf2ffa046b8390fbc4165c38030)

[gem]: https://rubygems.org/gems/multi_mime
[travis]: http://travis-ci.org/karlfreeman/multi_mime
[codeclimate]: https://codeclimate.com/github/karlfreeman/multi_mime
[gittip]: https://www.gittip.com/karlfreeman
[jruby]: http://www.jruby.org
[rubinius]: http://rubini.us
