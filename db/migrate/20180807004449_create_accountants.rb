class CreateAccountants < ActiveRecord::Migration[5.2]
  def change
    create_table :accountants do |t|

      t.timestamps
    end
  end
end
