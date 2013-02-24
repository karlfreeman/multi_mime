# MultiMime
[![Gem Version](https://badge.fury.io/rb/multi_mime.png)][gem]
[![Build Status](https://travis-ci.org/karlfreeman/multi_mime.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/karlfreeman/multi_mime.png?travis)][gemnasium]
[![Code Climate](https://codeclimate.com/github/karlfreeman/multi_mime.png)][codeclimate]

[gem]: https://rubygems.org/gems/multi_mime
[travis]: http://travis-ci.org/karlfreeman/multi_mime
[gemnasium]: https://gemnasium.com/karlfreeman/multi_mime
[codeclimate]: https://codeclimate.com/github/karlfreeman/multi_mime

A generic swappable back-end for Mime Type detection

## Usage Examples
Lots of Ruby libraries utilize Mime Type detection in some form. In order to best support multiple Mime Type detection libraries, `multi_mime` is a general-purpose swappable Mime Type detection backend library. You
use it like so:

```ruby
require 'multi_mime'

MultiMime.type_for('text/html') # 'text/html' 
# alias :by_type

MultiMime.type_for_extension('.html') # 'text/html'
# alias :by_extension

MultiMime.type_for_path('/usr/local/foo/bar/foo.jpg') # 'text/html'
# alias :by_path

MultiMime.type_for_file( File.open('foo.html', 'w') ) # 'text/html'
# alias :by_file
```

## Supported Mime Engines

* [MIME::Types](https://github.com/halostatue/mime-types)
* [MagicMime](https://github.com/minad/mimemagic)
* [Rails](http://api.rubyonrails.org/classes/Mime/Type.html) ( ActionDispatch::Http::Mime )
* [Rack](http://rack.rubyforge.org/doc/Rack/Mime.html) ( Rack::Mime )

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0
* [JRuby][]
* [Rubinius][]

[jruby]: http://www.jruby.org/
[rubinius]: http://rubini.us/

# Credits

Inspiration:

* [MultiJSON](https://github.com/intridea/multi_json)
* [MultiXML](https://github.com/sferik/multi_xml)

Cribbed:

* [MultiJSON](https://github.com/intridea/multi_json)
* [Asset_Sync's MultiMime module](https://github.com/rumblelabs/asset_sync/commit/9333bd01ae1a7cf2ffa046b8390fbc4165c38030)
