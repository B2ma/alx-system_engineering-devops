#!/usr/bin/env ruby
#puts ARGV[0].scan(/from:(\w+|\+?\d+)|to:(\+?+\d+)|flags:((-|\d|:|)+)/).map(&:compact).join(',')
puts ARGV[0].scan(/(?:from:(\w+|\+?\d+)|to:(\+?\d+)|flags:((-|\d|:|)+))/).map { |match| match.compact.join }.join(',')


