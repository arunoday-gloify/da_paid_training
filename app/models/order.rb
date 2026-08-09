class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  enum :status,
       { pending: "pending", paid: "paid", shipped: "shipped", cancelled: "cancelled", refunded: "refunded" },
       default: "pending",
       validate: true

  validates :order_items, presence: true

  before_validation :recalculate_total

  private

  def recalculate_total
    live_items = order_items.reject(&:marked_for_destruction?)
    live_items.each(&:snapshot_unit_price)
    self.total_cents = live_items.sum(&:subtotal_cents)
  end
end
