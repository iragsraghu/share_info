class Subscription < ApplicationRecord
  require 'net/http'
  before_create :is_post_url?
  before_create :generate_api_key

  validates :callback_url, presence: true, uniqueness: true

  private

  def is_post_url?
    unless check_post_method(self.callback_url)
      errors.add(:base, "HTTP method 'POST' is required for record creation")
      throw(:abort)
    end
  end

  def check_post_method(callback_url)
    url = URI.parse(callback_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true if url.scheme == 'https'

    request = Net::HTTP::Options.new(url.path)
    request['User-Agent'] = 'Mozilla/5.0'

    response = http.request(request)
    if response.present?
      http_methods = response.to_hash["access-control-allow-methods"].first.split(",").map(&:strip)
      http_methods.include?("POST")
    else
      false
    end
  rescue StandardError
    false
  end

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
  end
end
