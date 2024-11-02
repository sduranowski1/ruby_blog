Trestle.resource(:posts) do
  menu do
    item :posts, icon: "fa fa-blog"
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center 
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  
  form do |post|
    # Organize fields into tabs and sidebars
    tab :post do
      text_field :title

      # Define custom form fields for easy re-use
      editor :content

      # Field for image upload
      row do
        col do
          file_field :image  # Add this line for image upload
        end
      end
    end

    tab :metadata do
      # Layout fields based on a 12-column grid
      row do
        # col(sm: 6) { select :author, User.all }
        col(sm: 6) {
          # Use tag_select with `tag_ids` to ensure it's sending tag IDs correctly
          select :category_ids, Category.all, { label: "Categories", multiple: true }, { selected: post.category_ids }
          select :tag_ids, Tag.all, { label: "Tags", multiple: true }, { selected: post.tag_ids }
        }  
      end
    end
    
    row do
      col { datetime_field :updated_at }
      col { datetime_field :created_at }
    end


  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:post).permit(:name, ...)
  # end
  # Permitting parameters for post creation and updating
  params do |params|
    params.require(:post).permit(:title, :content, :image, tag_ids: [], category_ids: [])
  end
end
