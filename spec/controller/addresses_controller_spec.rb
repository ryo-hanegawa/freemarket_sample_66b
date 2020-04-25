require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
    let(:user) {create(:user)}
  
    describe 'GET #step3' do
    it "住所登録ページに遷移するか" do
      login_user user
      get :step3
      expect(response).to render_template :step3
    end
  end
  
end
