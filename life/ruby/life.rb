#!/usr/bin/env ruby
require 'benchmark'
require 'optparse'

require "./board"

options = { filename: "example.txt", report_generations: 100, generations: 1_000_000_000, height: 40, width: 120, delay: 0, random: false }

if ARGV.first && !ARGV.first.start_with?('-')
  options[:filename] = ARGV.shift
end

OptionParser.new do |opts|
  opts.banner = "Usage ./life.rb [seed file] [options]"
  opts.on("-r", "--report") { |v| options[:report] = v }
  opts.on("--report-generations [generations]") { |v| options[:report_generations] = v.to_i }
  opts.on("-g [generations]", "--generations [generations]") { |v| options[:generations] = v.to_i }
  opts.on("-h height", "--height height") { |v| options[:height] = v.to_i }
  opts.on("-w width", "--width width") { |v| options[:width] = v.to_i }
  opts.on("-d delay", "--delay delay") { |v| options[:delay] = v.to_f }
  opts.on("--random") { |v| options[:random] = v }
end.parse!

seed_data = nil

unless options[:random]
  seed_data = File.read(options[:filename])
else
  seed_data = options[:height].times.map do
    options[:width].times.map do
      ["-","#"].sample
    end.join()
  end.join("\n")
end

board = Board.new seed_data, (options.select { |k| [:height, :width].include? k })

if options[:report]
  Benchmark.bm 30 do |x|
    x.report "#{options[:report_generations]} generations" do
      options[:report_generations].times do
        board.next_generation!
      end
    end
  end
else
  options[:generations].times do
    rt = Benchmark.realtime do
      board.next_generation!
    end
    puts board
    puts "Calculated in #{rt}"
    if options[:delay] > 0
      sleep options[:delay]
    end
  end
end
