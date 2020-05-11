describe "GET #show"
it "商品詳細ページに遷移するか" do
  item = create(:item)
  get :show, params: {id: product}
end

describe "GET #edit"
it "商品編集ページに遷移するか" do
  get :edit, params: {;id: product}
end