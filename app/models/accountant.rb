class Accountant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accounts
  has_many :items
  belongs_to :family, optional: true
  has_many :tasks

  validates_presence_of :name

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
    Task.where(accountant_id: self.id, done: false).where('due_date < :current_month', current_month: current_month).to_a
  end

  def current_debts
    start = Date.today.at_beginning_of_month
    final = Date.today.at_end_of_month
    Task.where(accountant_id: self.id, due_date: start..final).to_a
  end

end
