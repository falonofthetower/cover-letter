shared_examples "requires admin" do
  it "redirects to root path" do
    session[:admin] = nil
    action
    expect(response).to redirect_to root_path
  end
end
