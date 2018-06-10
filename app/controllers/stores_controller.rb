class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @stores = Store.find(params[:id])
    @stores = parsearStore(@stores)
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  def newStore
    name = deparser(params[:nombre])
    lat = deparser(params[:latitud])
    lon = deparser(params[:longitud])
    address= deparser(params[:direccion])
    desc= deparser(params[:descripcion])
    image= deparser(params[:imagen])
    @store= Store.new(nombre: name, latitud: lat, longitud: lon, direccion: address, descripcion: desc, imagen: image)
    respond_to do |format|
      if @store.save
        @store = parsearStore(@store)
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def parsearStore(store)
    store.nombre = parser(store.nombre)
    store.latitud = parser(store.latitud)
    store.longitud = parser(store.longitud)
    store.direccion = parser(store.direccion)
    store.descripcion = parser(store.descripcion)
    store.imagen = parser(store.imagen)
    return store
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:nombre, :latitud, :longitud, :direccion, :descripcion, :imagen)
    end
end
