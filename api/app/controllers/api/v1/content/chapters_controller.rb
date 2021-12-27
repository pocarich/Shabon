module Api::V1::Content
  class ChaptersController < ApplicationController
    before_action :set_chapter, only: [:show, :update, :destroy]
  
    # GET /chapters
    def index
      @chapters = Chapter.all
  
      render json: @chapters
    end

    # GET /chapters_in_repository/1
    def index_in_repository
      @chapters = Chapter.where(repository_id: params[:id]).select(:id, :title, :view, :favorite, :created_at, :updated_at)

      render json: @chapters
    end

    # GET /chapters_detail_in_repository/1
    def index_detail_in_repository
      @chapters = Chapter.where(repository_id: params[:id])

      render json: @chapters
    end
  
    # GET /chapters/1
    def show
      render json: @chapter
    end

    # GET /chapter_with_repository/1
    def show_with_repository
      @chapter = Chapter.joins(:repository).eager_load(:repository).select('chapters.*, repositories.title AS repository_title').find(params[:id])

      render json: @chapter
    end
  
    # POST /chapters
    def create
      @chapter = Chapter.new(chapter_params)
  
      if @chapter.save
        render json: @chapter, status: :created
      else
        render json: @chapter.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /chapters/1
    def update
      if @chapter.update(chapter_params)
        render json: @chapter
      else
        render json: @chapter.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /chapters/1
    def destroy
      @chapter.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chapter
        @chapter = Chapter.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def chapter_params
        params.require(:chapter).permit(:repository_id, :title, :text, :view, :favorite)
      end
  end
end
