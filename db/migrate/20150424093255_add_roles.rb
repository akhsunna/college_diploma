class AddRoles < ActiveRecord::Migration
  def up
    query = <<-SQL
      INSERT INTO roles (name) VALUES ('student'), ('teacher'), ('admin');
    SQL
    ActiveRecord::Base.connection.execute(query)
  end

  def down
    query = <<-SQL
      DELETE FROM roles;
    SQL
    ActiveRecord::Base.connection.execute(query)
  end
end
