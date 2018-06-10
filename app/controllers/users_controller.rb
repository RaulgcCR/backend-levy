class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def newUser
    name = deparser(params[:nombre])
    lastname = deparser(params[:primerapellido])
    secondlastname = deparser(params[:segundoapellido])
    mail= deparser(params[:correo])
    pwd= deparser(params[:password])
    tok= createToken()
    image= deparser(params[:foto])
    @user= User.new(nombre: name, primerApellido: lastname, segundoApellido: secondlastname, contrasenna: pwd, correo: mail, foto: image, token: tok)
    respond_to do |format|
      if @user.save
        @user = parsearUsuario(@user)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def newLog
    mail = deparser(params[:correo])
    pwd = deparser(params[:password])
    valor = Usuario.where(correo: mail, contrasenna: pwd)
      valor.each do |parte|
        parte = parsearUsuario(parte)
      end
    @user = valor
  end

  def newLogToken
    valor = Usuario.where(token: params[:token])
    valor.each do |parte|
      parte = parsearUsuario(parte)
    end
    @user = valor
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(nombre: params[:user][:nombre], primerApellido: params[:user][:primerApellido], segundoApellido: params[:user][:segundoApellido], correo: params[:user][:correo], contrasenna: params[:user][:contrasenna], foto: params[:user][:foto], token: params[:user][:token])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def modifyUser
    name = deparser(params[:nombre])
    lastname = deparser(params[:primerapellido])
    secondlastname = deparser(params[:segundoapellido])
    mail= deparser(params[:correo])
    pwd= deparser(params[:password])
    image= deparser(params[:foto])
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(nombre: name, primerApellido: lastname, segundoApellido: secondlastname, correo: mail, contrasenna: pwd, foto: image)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :show }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
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
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user][:token] = createToken()
    params.require(:user).permit(:nombre, :primerApellido, :segundoApellido, :correo, :contrasenna, :foto, :token)
  end
end
