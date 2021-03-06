class UpdateContent < ActiveRecord::Migration
  def change
    #category = Category.find_by(name: 'About Me')
    #category.text = File.read('About Me.text.txt')
    #category.save
    directory = 'app/assets/text/'
    dirs = Dir.entries(directory)#.map{|f| f.split('.')}

    Article.all.each do |article|
      if !dirs.include? ('article.' + article.name)
        article.destroy
      end
    end

    dirs.each do |dir|
      file = dir.split('.')
      if file[0] == 'category'
        category = Category.find_by(name: file[1])
        attributes = Dir.entries(directory + dir).reject{|entry| entry =~ /^\.{1,2}$/}
        if !category.nil?
          attributes.each do |attr|
            category[attr] = File.read(directory + dir +'/'+ attr)
          end
          #category[file[2]] = File.read(directory +  dir)
          category.save
        end
      end
      if file[0] == 'article'
        article = Article.find_by(name: file[1])
        attributes = Dir.entries(directory + dir).reject{|entry| entry =~ /^\.{1,2}$/}
        if !article.nil?
          attributes.each do |attr|
            article[attr] = File.read(directory + dir +'/'+ attr)
          end
          article.save
        end

=begin
        article = Article.find_by(name: file[1])
        if !article.nil?
          article[file[2]] = File.read(directory +  dir)
          article.save
        end
=end
      end
    end
  end
end
