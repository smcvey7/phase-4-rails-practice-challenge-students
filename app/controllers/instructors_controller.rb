class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = find_instructor
    render json: instructor
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def update
    instructor = find_instructor
    instructor.update!(instructor_params)
    render json: instructor, status: :accepted
  end

  def destroy
    instructor = find_instructor
    instructor.destroy
    head :no_content
  end

  private
  
  def instructor_params
    params.permit(:name)
  end

  def find_instructor
    Instructor.find_by!(id: params[:id])
  end

  def render_record_not_found
    render json: {error: "instructor not found"}, status: :not_found
  end

  def render_record_invalid(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end

end
