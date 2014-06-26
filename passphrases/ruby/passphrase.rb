#!/usr/bin/env ruby

require 'optparse'

options = {
  dictionary_path: "/usr/share/dict/words",
  min_word_length: 3,
  word_count: 4
}

OptionParser.new do |opts|
  opts.banner = "Usage passwdgen.rb [options]"
  opts.on("-d", "--dictionary FILEPATH", "Choose a specific dictionary file. Default: #{options[:dictionary_path]}") do |file_path|
    options[:dictionary_path] = file_path
  end

  opts.on("-w", "--wordcount N", "Choose the word count. Default: #{options[:word_count]} ") do |count|
    options[:word_count] = count.to_i
  end

  opts.on("-m", "--min-word-length", "Choose the minimum length for each word. Default: #{options[:min_word_length]} ") do |min|
    options[:min_word_length] = min.to_i
  end
end.parse!


words = File.readlines(options[:dictionary_path]).reduce([]) do |memo,word|
  memo << word.chomp if word.chomp.length >= options[:min_word_length]
  memo
end

puts words.sample(options[:word_count]).join(' ') + "!?.".split('').sample
