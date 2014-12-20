class AddLenderToUsers < ActiveRecord::Migration
  def change
    add_column :debts, :lender, :string
  end
end
