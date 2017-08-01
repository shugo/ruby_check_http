#!/usr/local/bin/ruby

require "optparse"
require "uri"
require "net/http"

DEFAULT_MIN_DAYS = 14

options = ARGV.getopts("d:")

begin
  uri = URI.parse(ARGV[0])
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
    if http.use_ssl?
      days = (http.peer_cert.not_after - Time.now) / (24 * 60 * 60)
      min_days = (options["d"] || DEFAULT_MIN_DAYS).to_i
      if days < min_days
        puts "The SSL certificate will expire #{days.to_i} days after"
        exit 1
      end
    end
    res = http.get(uri.path.sub(/\A\z/, "/"))
    puts "#{uri} returned #{res.code}"
    case res.code
    when /\A2/
      exit 0
    else
      exit 2
    end
  end
rescue
  puts $!
  exit 2
end
