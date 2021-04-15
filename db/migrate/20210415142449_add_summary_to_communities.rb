class AddSummaryToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :summary, :string
  end
end
