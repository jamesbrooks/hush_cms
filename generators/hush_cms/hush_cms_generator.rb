class HushCmsGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.migration_template 'hush_cms_migration.rb',
        File.join('db', 'migrate'),
        :migration_file_name => "create_hush_cms_components"
    end
  end
end
