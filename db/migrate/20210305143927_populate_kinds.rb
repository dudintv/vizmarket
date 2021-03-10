class PopulateKinds < ActiveRecord::Migration[6.0]
  def up
    Kind.find_or_create_by title: 'script'
    Kind.find_or_create_by title: 'shader'
    Kind.find_or_create_by title: 'scene'
    Kind.find_or_create_by title: 'plugin'
    Kind.find_or_create_by title: 'tutorial'
  end

  def down
    Kind.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(Kind.table_name) # reset auto-increment of id (ONLY FOR PSQL)
  end
end
