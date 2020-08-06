class CombineItemsInCart < ActiveRecord::Migration[6.0]
  def up
    # 카트에 한 상품이 여러 개 담긴 경우 multiple item으로 교체
    Cart.all.each do |cart|
      # 카트에 있는 각 상품의 수를 셈
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # 개개의 items 제거
          cart.line_items.where(product_id: product_id).delete_all
          # 한 개 아이템으로 교체
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
  #  1보다 큰 multiple items을 분리한다
    LineItem.where('quantity > 1').each do |line_item|
      # 개별 아이템을 합
      line_item.quantity.times do
        LineItem.create(cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1)
      end

      # remove original item
      line_item.destroy
    end
  end
end
