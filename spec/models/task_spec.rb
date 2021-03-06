# == Schema Information
#
# Table name: tasks
#
#  id            :bigint(8)        not null, primary key
#  description   :string
#  done          :boolean          default(FALSE)
#  due_date      :date
#  name          :string
#  task_type     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accountant_id :bigint(8)
#
# Indexes
#
#  index_tasks_on_accountant_id  (accountant_id)
#
# Foreign Keys
#
#  fk_rails_...  (accountant_id => accountants.id)
#


require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'have atrributes' do
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:done) }
    it { is_expected.to respond_to(:due_date) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:task_type) }
  end

  let!(:accountant) { create(:accountant) }
  let!(:facade) { Facade.new(accountant) }

  context 'save' do
    it 'increase one task' do
      task = build(:task, accountant: accountant)
      expect {
        facade.insert(task)
      }.to change(Task, :count).by(1)
    end
  end

  context 'update' do
    it 'modify attributes' do

      task = create(:task, accountant: accountant)

      name = Faker::Name.name
      description = Faker::Book.publisher

      facade.update(task, attributes: { name: name, description: description })

      task_from_db = Task.find(task.id)
      expect(task_from_db.name).to eq(name)
      expect(task_from_db.description).to eq(description)
    end
  end

  context 'delete' do
    let!(:task) { create(:task, accountant: accountant) }
    it 'decrease one item' do
      expect {
        facade.delete(task)
      }.to change(Task, :count).by(-1)
    end

  end

  context 'select' do

    it 'return list of items' do
      amount = 10

      create_list(:task, amount, accountant: accountant)

      transporter = facade.select :task
      expect(transporter.bucket[:tasks].count).to eq(amount)
    end
  end

end
