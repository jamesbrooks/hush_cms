class HushCmsAdmin::CommentsController < HushCmsAdminController
  before_filter :find_comment, :except => :index
  
  
  def index
    @comments = HushCMS::Comment.unapproved.find(:all, :include => :post).group_by(&:post)
  end
  
  def approve
    @comment.approve!
    redirect_to :back
  end
  
  def unapprove
    @comment.unapprove!
    redirect_to :back
  end
  
  
private
  def find_comment
    @comment = HushCMS::Comment.find(params[:id])
  end
end
