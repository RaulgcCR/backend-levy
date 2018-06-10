class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end


  def findArticle
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      @cadena = deparser(params[:cadena])
      @articles = Article.all
      if @cadena
        #@articles = Article.where(:nombre => @cadena)
        @articles = Article.where("nombre like ?", "%#{@cadena}%")
      end
    else
      respond_to do |format|
        @article = Article.new()
        format.html { render :show }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def newArticle
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      name = deparser(params[:nombre])
      desc = deparser(params[:descripcion])
      price= params[:precio]
      provider= params[:proveedor]
      image= deparser(params[:imagen])
      mode= params[:modo]
      @article= Article.new(nombre: name, precio: price, descripcion: desc, proveedor: provider, image: image, modo: mode)
      respond_to do |format|
        if @article.save
          @article = parsearArticulo(@article)
          format.html { redirect_to @article, notice: 'Article was successfully created.' }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { render :new }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @article = Article.new()
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


  def modifyArticle
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      name = deparser(params[:nombre])
      desc = deparser(params[:descripcion])
      price= params[:precio]
      provider= params[:proveedor]
      image= deparser(params[:imagen])
      mode= params[:modo]
      @article = Article.find(params[:id])
      respond_to do |format|
        if @article.update(nombre: name, precio: price, descripcion: desc, proveedor: provider, image: image, modo: mode)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit}
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @article = Article.new()
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deleteArticle
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      @article = Article.find(params[:id])
      respond_to do |format|
        if @article.destroy
          format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @article = Article.new()
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def parsearArticulo(art)
    art.nombre = parser(art.nombre)
    art.descripcion = parser(art.descripcion)
    art.image = parser(art.image)
    return art
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:nombre, :precio, :descripcion, :proveedor, :image, :modo)
    end
end
