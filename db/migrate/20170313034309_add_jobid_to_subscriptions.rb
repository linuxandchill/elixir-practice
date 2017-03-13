class AddJobidToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :jobid, :string
  end
end
