class Cat < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string      :name, :null => false
      t.integer     :age, :null => false
      t.string      :birth_date, :null => false
      t.string      :sex, :null => false, :length => 1
      t.timestamps
    end
  end

end
