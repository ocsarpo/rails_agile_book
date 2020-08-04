class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\z}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private
  # 이 product를 참조하고 있는 line_item이 없다는 것을 보장함
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
