class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  def indexScore
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      score = Score.where(calificado: params[:id])
      len=score.length
      cant=0
      score.each do |art|
        cant= cant+ art.calificacion
      end
      if len > 0
        @score = cant/len
      else
        @score = false
      end
    else
      respond_to do |format|
        @score = Score.new()
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  def newScore
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      cali = params[:calificado]
      calif = params[:calificador]
      califi= params[:calificacion]
      @score= Score.new(calificado: cali, calificador: calif, calificacion: califi)
      respond_to do |format|
        if @score.save
          format.html { redirect_to @score, notice: 'Score was successfully created.' }
          format.json { render :show, status: :created, location: @score }
        else
          format.html { render :new }
          format.json { render json: @score.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @score = Score.new()
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to @score, notice: 'Score was successfully created.' }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score, notice: 'Score was successfully updated.' }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  def modifyScore
    @user = nil
    User.all.each do |usu|
      if usu.token == params[:token]
        @user = usu
      end
    end
    if @user != nil
      cali = params[:calificado]
      calif = params[:calificador]
      califi= params[:calificacion]
      @score = Score.find(params[:id])
      respond_to do |format|
        if @score.update(calificado: cali, calificador: calif, calificacion: califi)
          format.html { redirect_to @score, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @score }
        else
          format.html { render :edit}
          format.json { render json: @score.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @score = Score.new()
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:calificado, :calificador, :calificacion)
    end
end
