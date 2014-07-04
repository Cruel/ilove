class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :word
      t.string :ip
      t.datetime :date
      t.attachment :image

      t.timestamps
    end
  end
end
