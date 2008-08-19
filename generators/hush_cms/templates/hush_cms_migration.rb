class CreateHushCmsComponents < ActiveRecord::Migration
  def self.up
    create_table :hush_cms_pages do |t|
      t.integer :parent_id, :position
      t.string :title, :description, :slug
      t.text :content
      t.datetime :published_at
      t.timestamps
    end
    
    create_table :hush_cms_categories do |t|
      t.string :name, :slug
      t.boolean :comments_allowed, :default => false
    end
    
    create_table :hush_cms_posts do |t|
      t.integer :category_id
      t.string :title, :author, :slug
      t.text :content
      t.datetime :published_at
    end
    
    create_table :hush_cms_comments do |t|
      t.integer :post_id
      t.string :naem, :email
      t.text :content
      t.boolean :approved, :default => false
    end
    
    # TODO: Add appropriate indexes
  end

  def self.down
    drop_table :hush_cms_pages
    drop_table :hush_cms_categories
    drop_table :hush_cms_posts
    drop_table :hush_cms_comments
  end
end
