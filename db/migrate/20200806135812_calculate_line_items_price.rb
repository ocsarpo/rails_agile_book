class CalculateLineItemsPrice < ActiveRecord::Migration[6.0]
  def up
    LineItem.includes(:product).all.each do |item|
      item.price = item.product.price
      item.save!
    end
  end

  def down
    LineItem.update_all(total_price: nil)
  end
end
