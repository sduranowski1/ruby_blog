class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.order(created_at: :desc)
  
    # Apply the search filter if query is present
    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @posts = @posts.where("LOWER(title) LIKE ? OR LOWER(content) LIKE ?", query, query)
    end
  
    # Apply tag filter if tag_id is present
    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @posts = @posts.joins(:tags).where(tags: { id: tag.id })
    end
  
    # Apply category filter if category_id is present
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      @posts = @posts.joins(:categories).where(categories: { id: category.id })
    end
  
    # Paginate after applying filters
    @posts = @posts.page(params[:page]).per(3)
  
    @categories = Category
      .select('categories.*, COUNT(posts.id) as post_count')
      .joins(:posts)
      .group('categories.id')
      .order('post_count DESC')
    @tags = Tag.all
  end
  

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    assign_tags(@post)
    assign_categories(@post)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    assign_tags(@post)  # Call your method to assign tags based on params
    assign_categories(@post)

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Filter posts by tags 
  def filter_by_tag
    @tag = Tag.find(params[:id]) # Get the tag by ID
    @posts = @tag.posts # Get posts associated with that tag
    respond_to do |format|
      format.js # This will render filter_by_tag.js.erb
    end
  end

  # Filter posts by tags 
  def filter_by_category
    @category = Category.find(params[:id]) # Get the tag by ID
    @posts = @category.posts # Get posts associated with that tag
    respond_to do |format|
      format.js # This will render filter_by_tag.js.erb
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :image, tag_ids: [], category_ids: [],)
    end

    # Assign tags to the post
    def assign_tags(post)
      tag_ids = params[:post][:tag_ids] || []  # Ensure it's at least an empty array
      tag_ids.reject!(&:blank?)                 # Remove any blank entries

      if tag_ids.any?
        tags = Tag.where(id: tag_ids)           # Use `where` instead of `find` to avoid errors if IDs don't exist
        post.tags = tags
      else
        post.tags.clear                          # Clear existing tags if no valid tag_ids are provided
      end
    end

    # Assign tags to the post
    def assign_categories(post)
      category_ids = params[:post][:category_ids] || []  # Ensure it's at least an empty array
      category_ids.reject!(&:blank?)                 # Remove any blank entries

      if category_ids.any?
        categories = Category.where(id: categories_ids)           # Use `where` instead of `find` to avoid errors if IDs don't exist
        post.categories = categories
      else
        post.categories.clear                          # Clear existing tags if no valid tag_ids are provided
      end
    end


end
