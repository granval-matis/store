class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :role, foreign_key: true, null: true

    reversible do |dir|
      dir.up do
        %w[guest buyer seller admin].each { |n| Role.find_or_create_by!(name: n) }

        guest = Role.find_by(name: 'guest')
        User.reset_column_information
        User.find_each { |u| u.update_columns(role_id: guest.id) }
      end
    end

    change_column_null :users, :role_id, false
  end
end
