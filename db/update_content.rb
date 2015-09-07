class UpdateContent < ActiveRecord::Migration
  def change
    directory = 'app/assets/text/'
    Dir.chdir(directory);
    #categories = Dir.entries(directory)#.map{|f| f.split('.')}
    categories = Dir.glob('*')
        .select{|f| File.directory? f}
        .reject{|entry| entry =~ /^\.{1,2}$/}

    allArticles = []
    Category.all.each do |category|
      if !categories.include? (category.name)
        category.destroy
      end
    end

    categories.each do |categoryName|
      Dir.chdir(categoryName) do
        #categoryPath = directory + categoryName + '/'
        category = Category.find_by(name: categoryName)
        attributes = Dir.glob('*')
            .select{|f| File.file? f}
        # Add category creator here

        if category.nil?
          categoryParams = Hash.new
          categoryParams['name'] = categoryName
          attributes.each do |attribute|
            #categoryParams[attribute.parameterize] = File.read(categoryPath +'/'+ attribute)
            categoryParams[attribute] = File.read(attribute)
          end
          category = Category.new(categoryParams)
        else
          attributes.each do |attribute|
            #category[attribute] = File.read(categoryPath +'/'+ attribute)
            category[attribute] = File.read(attribute)
          end
        end
        category.save!




        #articles = Dir.glob(categoryPath + '*')
        articles = Dir.glob('*')
            .select{|f| File.directory? f}
            .reject{|entry| entry =~ /^\.{1,2}$/}
        allArticles += articles
        articles.each do |articleName| 
          Dir.chdir(articleName) do 
            #articlePath = articleName + '/';
            article = Article.find_by(name: articleName)
            #attributes = Dir.glob(articlePath + '*')
            attributes = Dir.glob('*')
                .select{|f| File.file? f}

            if article.nil?
              articleParams = Hash.new
              articleParams['name'] = articleName
              attributes.each do |attribute|
                #articleParams[attribute.parameterize] = File.read(articlePath +'/'+ attribute)
                articleParams[attribute] = File.read(attribute)
              end
              article = category.articles.create(articleParams)
            else
              attributes.each do |attribute|
                #article[attribute] = File.read(categoryPath +'/'+ attribute)
                article[attribute] = File.read(attribute)
              end
            end
            article.save!
          end
        end
      end 
    end
    Article.all.each do |article|
      if !allArticles.include? (article.name)
        article.destroy
      end
    end
  end
end
