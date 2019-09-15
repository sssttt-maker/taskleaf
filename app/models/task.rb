class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_null_including_colmma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  private

  def validate_name_not_null_including_colmma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
