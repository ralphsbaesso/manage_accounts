# == Schema Information
#
# Table name: accountants
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  owner                  :boolean          default(FALSE)
#  profile                :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  family_id              :bigint(8)
#
# Indexes
#
#  index_accountants_on_email                 (email) UNIQUE
#  index_accountants_on_family_id             (family_id)
#  index_accountants_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (family_id => families.id)
#

class Accountant < ApplicationRecord
  extend RuleMap
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accounts
  has_many :items
  belongs_to :family, optional: true
  has_many :debts

  validates_presence_of :name
  after_create :create_defaut_item

  def account_ids
    self.accounts.map { |account| account.id }
  end

  def subitems
    Subitem.joins(
      'JOIN items ON items.id = subitems.item_id'
    ).where(
      'items.accountant_id = :id', id: self.id
    )
  end

  def late_debts
    current_month = Date.today.at_beginning_of_month
    Task.where(accountant_id: self.id, done: false, task_type: :debt).where('due_date < :current_month', current_month: current_month).to_a
  end

  def current_debts
    start = Date.today.at_beginning_of_month
    final = Date.today.at_end_of_month
    Task.where(accountant_id: self.id, done: false, task_type: :debt, due_date: start..final).to_a
  end

  def create_defaut_item
    item = Item.create(name: 'Outros', description: 'outros', accountant: self)
    Subitem.create(name: 'Outros', description: 'outros', item: item)
  end

end
