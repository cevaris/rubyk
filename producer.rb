#!/usr/bin/env ruby


require 'kafka'
require 'securerandom'
require 'json'


def new_job
  job_id = SecureRandom.uuid()[0..12]
  job_name = "Job: #{job_id}"
  job_location = "jobs_rowkey#{job_id}"
  {id: job_id, name: job_name, location: job_location}.to_json
end

opts = {host: 'localhost', port: 9092, topic: 'analytics_complete'}
producer = Kafka::Producer.new(opts)
puts "Sending to #{producer.host}:#{producer.port}:#{producer.topic}"

(1..10).each do
  job = new_job()
  hourly_job_completed_message = Kafka::Message.new(job)
  producer.push(hourly_job_completed_message)
  puts "Sent Job #{job}"
end