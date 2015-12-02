class AddAttachmentMapPictureToMatches < ActiveRecord::Migration
  def self.up
    change_table :matches do |t|
      t.attachment :map_picture, :after => :engine
    end
  end

  def self.down
    remove_attachment :matches, :map_picture
  end
end
