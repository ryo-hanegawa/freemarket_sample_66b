require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
    let(:user) {create(:user)}
  
    describe 'GET #users/registrations#new_address' do
    it "住所登録ページに遷移するか" do
      login_user user
      get :addresses
      expect(response).to render_template :address
    end
  end
  
end
