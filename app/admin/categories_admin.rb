Trestle.resource(:categories) do
    menu do
        item :categories, icon: "fa fa-list"
    end
    # Customize the table displayed in the admin panel
    # table do
    #   column :name
    #   column :post_count, header: 'Post Count' do |category|
    #     category.posts.count
    #   end
  
    #   actions do |category|
    #     # Add custom actions if needed
    #     link :edit, category
    #     link :delete, category
    #   end
    # end
  
    # Customize the form displayed when adding/editing a category
    form do |category|
      text_field :name
    end
  end
  