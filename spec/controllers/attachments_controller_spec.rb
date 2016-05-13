require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:attachment) { create(:attachment) }

  context '#destroy' do
    
    it "assigns attachment to @attachment" do
      delete :destroy, id: attachment, format: :js
      expect(assigns(:attachment)).to eq(attachment)
    end

    it 'deletes attachment' do
      expect{ delete :destroy, id: attachment, format: :js }
        .to change{ Attachment.count }.from(1).to(0)
    end

    it "returns temapate" do
      delete :destroy, id: attachment, format: :js
      expect(response).to render_template :destroy
    end
  end

end
