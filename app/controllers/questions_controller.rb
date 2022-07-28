class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[destroy edit update show]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Вопрос создан!"
      redirect_to questions_path
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "Вопрос удален!"
    redirect_to questions_path
  end

  def edit
  end

  def update
    if @question.update question_params
      flash[:success] = "Вопрос обновлен!"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order created_at: :desc
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end
end