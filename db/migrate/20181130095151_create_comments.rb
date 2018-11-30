class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
			t.references :user
			t.references :post
			t.string :content
			t.string :ip_address
      t.timestamps
    end
  end
end
