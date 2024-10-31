class ChangeRoleToNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:users, :user_role, false)
  end
end
