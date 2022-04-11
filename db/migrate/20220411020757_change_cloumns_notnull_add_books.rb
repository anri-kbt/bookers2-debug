class ChangeCloumnsNotnullAddBooks < ActiveRecord::Migration[6.1]
  def up
    change_column_null :books, :evaluation, false
  end

  def down
    change_column_null :books, :evaluation, true
  end
end
