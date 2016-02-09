class AddRequestToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :request, :boolean, default: false
  end
end
