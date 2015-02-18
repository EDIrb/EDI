RSpec.shared_context "service" do
  let(:service) { TestService }
 end

module ServiceContext
  def self.included(base)
    base.include_context "service"
  end
end
