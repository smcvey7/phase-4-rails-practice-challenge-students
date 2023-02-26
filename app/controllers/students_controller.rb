class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def index
    students = Student.all
    render json: students
  end

  def show
    student = find_student
    render json: student
  end

  def create
    student = Student.create!(student_params)
    render json: student, status: :created
  end

  def update
    student = find_student
    student.update!(student_params)
    render json: student, status: :accepted
  end

  def destroy
    student = find_student
    student.destroy
    head :no_content
  end

  private
  
  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def find_student
    Student.find_by!(id: params[:id])
  end

  def render_record_not_found
    render json: {error: "student not found"}, status: :not_found
  end

  def render_record_invalid(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end
end
