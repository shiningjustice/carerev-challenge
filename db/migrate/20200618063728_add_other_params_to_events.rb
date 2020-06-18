class AddOtherParamsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :other_params, :json
  end
end
