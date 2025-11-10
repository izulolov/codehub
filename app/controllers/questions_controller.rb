class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :load_question, only: [ :show, :edit, :update, :destroy ]

  def index
    @questions = Question.all
  end

  def show
    if params[:edit_answer_id]
      @answer = @question.answers.find(params[:edit_answer_id])
    else
      @answer = Answer.new(question_id: @question.id)
    end
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: "Your question was succesfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: "Your question was succesfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question was successfully deleted"
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
