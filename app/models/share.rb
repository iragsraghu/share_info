class Share < ApplicationRecord
	before_save :update_columns
	after_create :notify_product_create
  after_update :notify_product_update


	validates :name, :symbol, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z ]+\z/, message: "allows only letters" }
	validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be a decimal value" }


	def notify_product_create
    notify_webhooks('created', self)
	end

  def notify_product_update
    notify_webhooks('updated', self)
  end

	private

	def update_columns
		self.name = name.strip if name.present?
		self.symbol = symbol.strip if symbol.present?
	end

	def notify_webhooks(event, record)
    subscriptions = Subscription.all
    subscriptions.each do |subscription|
      WebhookJob.perform_now(subscription.callback_url, subscription.api_key, event, record)
    end
  end
end
