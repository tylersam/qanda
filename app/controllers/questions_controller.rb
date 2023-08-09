class QuestionsController < ApplicationController
  before_action :set_users_question, only: %i[edit update destroy]

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)

    respond_to do |format|
      if @question.save
        format.html do
          redirect_to question_url(@question),
                      notice: 'Question was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html do
          redirect_to question_url(@question),
                      notice: 'Question was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.html do
        redirect_to root_path,
                    notice: 'Question was successfully destroyed.'
      end
    end
  end

  private

  def set_users_question
    @question = current_user.questions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path,
                alert: 'Not allowed to modify another user\'s question'
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
