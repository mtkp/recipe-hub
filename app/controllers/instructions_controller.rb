class InstructionsController < ApplicationController
  include CurrentRecipe
  before_action :set_editable_recipe
  before_action :set_instruction, only: [:show, :edit, :update, :destroy]

  # GET /instructions/new
  def new
    @instruction = Instruction.new
  end

  # GET /instructions/1/edit
  def edit
  end

  # POST /instructions
  # POST /instructions.json
  def create
    @instruction = @recipe.instructions.build(instruction_params)

    respond_to do |format|
      if @instruction.save
        format.html { redirect_to @recipe, notice: 'Instruction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @instruction }
      else
        format.html { render action: 'new' }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructions/1
  # PATCH/PUT /instructions/1.json
  def update
    respond_to do |format|
      if @instruction.update(instruction_params)
        format.html { redirect_to @recipe, notice: 'Instruction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructions/1
  # DELETE /instructions/1.json
  def destroy
    respond_to do |format|
      if @instruction.destroy
        format.html { redirect_to @recipe }
        format.json { head :no_content }
      else
        format.html { redirect_to @recipe, notice: 'Instruction could not be deleted' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instruction
      @instruction = @recipe.instructions.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access non-existant or unauthorized instruction"
      redirect_to @recipe, alert: "Instruction was not found."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instruction_params
      params.require(:instruction).permit(:body)
    end
end
