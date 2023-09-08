#!/usr/bin/env ruby
puts ARGV[0].scan(/from+:(\w+|\+?\d+)|to+:(\+?+\d+)|flags+:(-+.{11})/).map(&:compact).join(',')
