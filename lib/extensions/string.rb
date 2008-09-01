class String  
  def slugify
    self.downcase.gsub(/&/, ' and ').gsub(/[^a-z0-9']+/, '-').gsub(/^-|-$|'/, '')
  end
end
