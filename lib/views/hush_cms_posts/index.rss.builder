xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title((HushCMS.configuration['feed'] ? HushCMS.configuration['feed']['title_prefix'].to_s : '') + @category.name)
    xml.link hush_cms_posts_url(@category.slug)
    xml.description @category.description
    
    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link hush_cms_post_url(:category => @category.slug, :year => post.published_at.year, :month => post.published_at.month, :day => post.published_at.day, :slug => post.slug)
        xml.author post.author
        xml.description post.content
        xml.pubDate post.published_at.to_s(:rfc882)
        xml.guid hush_cms_post_url(:category => @category.slug, :year => post.published_at.year, :month => post.published_at.month, :day => post.published_at.day, :slug => post.slug)
        
        if @category.has_comments?
          xml.comments(hush_cms_post_url(:category => @category.slug, :year => post.published_at.year, :month => post.published_at.month, :day => post.published_at.day, :slug => post.slug) + '#comments')
        end
      end
    end
  end
end
