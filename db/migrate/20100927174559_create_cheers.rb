class CreateCheers < ActiveRecord::Migration
  def self.up
    create_table :cheers do |t|
      t.integer :user_id
      t.integer :post_id 
      t.integer :rating
      t.timestamps
    end
  end

  def self.down
    drop_table :cheers
  end
end
