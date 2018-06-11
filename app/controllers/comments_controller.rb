class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  def newMostrar
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      @comments = Comment.where(articulo: params[:articulo])
      @users = []
      @comments.each do |comment|
        comment = parsearComment(comment)
        @users.insert(-1, User.find(comment.persona))
      end
      @users.each do |user|
        user = parsearUsuario(user)
      end
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  def newComment
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      art = params[:articulo]
      pers = params[:persona]
      comm= deparser(params[:comentario])
      @comment= Comment.new(articulo: art, persona: pers, comentario: comm)
      respond_to do |format|
        if @comment.save
          @comment = parsearComment(@comment)
          format.html { redirect_to @comment, notice: 'Score was successfully created.' }
          format.json { render :show, status: :created, location: @comment}
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @comment = Comment.new()
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def parsearComment(comm)
    comm.comentario = parser(comm.comentario)
    return comm
  end

  def parsearUsuario(user)
    user.nombre = parser(user.nombre)
    user.primerApellido = parser(user.primerApellido)
    user.segundoApellido = parser(user.segundoApellido)
    user.foto = parser(user.foto)
    user.correo = parser(user.correo)
    user.contrasenna = parser(user.contrasenna)
    return user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:articulo, :persona, :comentario)
    end
end
