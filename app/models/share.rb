class Share < ApplicationRecord
	before_save :trim_columns

	validates :name, :symbol, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z ]+\z/, message: "allows only letters" }
	validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be a decimal value" }

	private

	def trim_columns
		self.name = name.strip if name.present?
		self.symbol = symbol.strip if symbol.present?
	end
end
