class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all.order(updated_at: 'desc')
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    redirect_to action: :index
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)
    @submission.user_id = current_user.id
    @submission.score = calc_score

    respond_to do |format|
      if @submission.save
        update_score_table
        update_current_user_scores

        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def calc_score
    case @submission.problem.category.id
    when 1 then
      masters = (@submission.problem.output || '').split("\n").map(&:chomp)
      users   = (@submission.output || '').split("\n").map(&:chomp)
      masters.zip(users).count {|a, b| a == b }
    when 2 then
      @submission.problem.output.chomp == @submission.output ? 100 : 0
    when 3 then
      (Submission.count(output: 'OK', problem_id: @submission.problem_id, user_id: current_user.id).to_i) * 100
    else
      0
    end
  end

  def update_score_table
    score = Score.where(user_id: current_user.id, problem_id: @submission.problem_id).first_or_initialize
    score.value = [score.value.to_i, @submission.score].max
    score.save
  end

  def update_current_user_scores
    scores = Score.where(user_id: current_user.id)
    current_user.total_score = scores.sum(:value).to_i

    current_user.pc_score  = scores.select {|score| score.problem.category.id == 1 }.map(&:value).reduce(&:+).to_i
    current_user.ctf_score = scores.select {|score| score.problem.category.id == 2 }.map(&:value).reduce(&:+).to_i
    current_user.ai_score  = scores.select {|score| score.problem.category.id == 3 }.map(&:value).reduce(&:+).to_i
    current_user.save
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    raise 'no permission' unless current_user && current_user.super?

    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    raise 'no permission' unless current_user && current_user.super?

    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def submission_params
    params.require(:submission).permit(:problem_id, :output)
  end
end
