#!/usr/bin/env ruby
puts ARGV[0].scan(/from:+([a-zA-Z]*)|to:+(\D\d*)|flags:+([\D{}\d]{12})/).flatten.compact.join(',')
