class UpdateAboutMe < ActiveRecord::Migration
  def change
    #category = Category.find_by(name: 'About Me')
    #category.text = File.read('About Me.text.txt')
    #category.save
    directory = 'app/assets/text/'
    entries = Dir.entries(directory)#.map{|f| f.split('.')}
    entries.each do |entry|
      file = entry.split('.')
      if file[0] == 'category'
        category = Category.find_by(name: file[1])
        if !category.nil?
          category[file[2]] = File.read(directory +  entry)
          category.save
        end
      end
      if file[0] == 'article'
        article = Article.find_by(name: file[1])
        if !article.nil?
          article[file[2]] = File.read(directory +  entry)
          article.save
        end
      end
    end
  end
end
