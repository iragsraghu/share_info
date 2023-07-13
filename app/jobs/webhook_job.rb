class WebhookJob < ApplicationJob
  queue_as :webhooks
  require 'rest-client'

  def perform(callback_url, api_key, event, record)
    headers = {'Content-Type' => 'application/json','api_key' => api_key}
    begin
      response = RestClient.post(callback_url, { event: event, payload: record}.to_json, headers)
      puts JSON.parse(response.body).merge!({callback_url: callback_url})
    rescue RestClient::ExceptionWithResponse => e
      puts "Webhook delivery failed with response code: #{e.response.code}"
      retry_job wait: 1.minutes, queue: :webhooks
    rescue StandardError => e
      puts "Webhook delivery failed with error: #{e.message}"
      retry_job wait: 1.minutes, queue: :webhooks
    end
  end
end