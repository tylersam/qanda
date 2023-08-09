class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_users_answer, only: %i[edit update destroy]

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html do
          redirect_to @answer.question,
                      notice: 'Answer was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html do
          redirect_to @answer.question,
                      notice: 'Answer was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer.destroy

    respond_to do |format|
      format.html do
        redirect_to @question, notice: 'Answer was successfully destroyed.'
      end
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_users_answer
    @answer = current_user.answers.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to @question, alert: 'Not allowed to modify another user\'s answer'
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
