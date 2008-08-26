class CreateHushCmsComponents < ActiveRecord::Migration
  def self.up
    create_table :hush_cms_pages do |t|
      t.integer :parent_id, :position
      t.string :title, :slug
      t.text :content
      t.datetime :published_at
      t.boolean :permanent, :default => false
      t.timestamps
    end
    
    create_table :hush_cms_categories do |t|
      t.string :name, :slug
      t.text :description
      t.boolean :has_comments, :default => false
      t.boolean :has_feed, :default => false
    end
    
    create_table :hush_cms_posts do |t|
      t.integer :category_id
      t.string :title, :author, :slug
      t.text :content
      t.datetime :published_at
      t.timestamps
    end
    
    create_table :hush_cms_comments do |t|
      t.integer :post_id
      t.string :name, :email
      t.text :content
      t.boolean :approved, :default => false
      t.timestamps
    end
    
    create_table :hush_cms_snippets do |t|
      t.string :name
      t.text :content
      t.timestamps
    end
    
    create_table :hush_cms_images do |t|
      t.string :name, :image_filename, :image_content_type
      t.integer :image_file_size
      t.text :content
      t.timestamps
    end
    
    # TODO: Add appropriate indexes
  end

  def self.down
    drop_table :hush_cms_pages
    drop_table :hush_cms_categories
    drop_table :hush_cms_posts
    drop_table :hush_cms_comments
    drop_table :hush_cms_snippets
    drop_table :hush_cms_images
  end
end
