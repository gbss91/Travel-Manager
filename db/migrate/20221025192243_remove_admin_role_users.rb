class RemoveAdminRoleUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column(:users, "user_role")
  end
end
