RSpec.shared_context "server" do
  let(:service) { TestServer }
 end

module ServerContext
  def self.included(base)
    base.include_context "server"
  end
end
