RSpec.shared_context "service" do
  let(:service) { TestService }
  let(:other_service) { OtherTestService }
 end

module ServiceContext
  def self.included(base)
    base.include_context "service"
  end
end
