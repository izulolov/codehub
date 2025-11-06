class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @question, notice: "Answer was successfully created."
    else
      # redirect_to @question, alert: "Failed to create answer." # Теряет ошибки
      flash.now[:alert] = "Failed to create answer."
      render "questions/show", status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
