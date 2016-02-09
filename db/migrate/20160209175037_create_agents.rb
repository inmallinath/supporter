class CreateAgents < ActiveRecord::Migration
  def up
    create_table :agents do |t|
      t.string :name
      t.string :email
      t.string :department
      t.text :message

      t.timestamps null: false
    end
  end

  def down
    drop_table :agents
  end
end
