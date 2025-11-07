class AnswersController < ApplicationController
  before_action :load_question, only: [ :create, :update ]

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to @question, notice: "Answer was successfully created."
    else
      flash.now[:alert] = "Failed to create answer."
      render "questions/show", status: :unprocessable_entity
    end
  end

  def update
    @answer = Answer.find(params[:id])

    if @answer.update(answer_params)
      redirect_to @question,
      notice: "Answer was successfully updated."
    else
      flash.now[:alert] = "Failed to update answer."
      render "questions/show", status: :unprocessable_entity
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
