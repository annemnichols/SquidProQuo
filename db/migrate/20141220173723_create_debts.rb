class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.string :description
      t.string :category
      t.boolean :is_fulfilled
      t.references :user, index: true

      t.timestamps
    end
  end
end
