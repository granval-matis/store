class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :comments
  enum role: { guest: 0, buyer: 1, seller: 2, admin: 3 }
  after_initialize :set_default_role, if: :new_record?
  attr_readonly :admin

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :first_name, :last_name, presence: true

  after_initialize :set_default_role, if: :new_record?

  generates_token_for :email_confirmation, expires_in: 7.days do
    unconfirmed_email
  end

  def confirm_email
    update(email_address: unconfirmed_email, unconfirmed_email: nil)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_create_product?
    admin? || seller?
  end

  def can_edit_product?(product)
    admin? || (seller? && product.user == self)
  end

  def can_delete_product?(product)
    admin? || (seller? && product.user == self)
  end

  private

  def set_default_role
    self.role ||= :buyer
  end
end
