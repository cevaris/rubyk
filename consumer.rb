#!/usr/bin/env ruby


require 'kafka'
require 'json'

opts = {host: 'localhost', port: 9092, topic: 'analytics_complete'}
consumer = Kafka::Consumer.new(opts)
puts "Listening on #{consumer.host}:#{consumer.port}"
consumer.loop do |messages|
  messages.each do |message|
    job = JSON.parse(message.payload)
    puts "Received: #{job['name']}"
  end
end