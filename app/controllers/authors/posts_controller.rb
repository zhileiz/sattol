module Authors
  class PostsController < AuthorController
    before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

    # GET /posts
    # GET /posts.json
    def index
      @posts = current_author.posts.recently_updated.paginate(:page => params[:page], :per_page => 6)
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
    end

    # GET /posts/new
    def new
      @post = Post.new
    end

    def publish
      @post.update(published: true)
      @post.update(published_at: Time.now)
      redirect_to :back
    end

    def unpublish
      @post.update(published: false)
      @post.update(published_at: nil)
      redirect_to :back
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts
    # POST /posts.json
    def create
      @post = Post.new(post_params)
      @post.author = current_author

      respond_to do |format|
        if @post.save
          format.html { redirect_to authors_posts_path(@post), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to authors_posts_path(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to authors_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :body, :description, :slug, :banner_image_url, :author_id)
      end

  end
end
