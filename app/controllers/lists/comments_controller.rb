class Lists::CommentsController < CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = List.find(params[:list_id])
    end
end
