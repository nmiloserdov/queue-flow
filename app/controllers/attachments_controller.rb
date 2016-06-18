class AttachmentsController < ApplicationController
  
  # skip_authorization_check

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
  end
end
