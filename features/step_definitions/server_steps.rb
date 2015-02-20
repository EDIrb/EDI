Given(/^a server is running with the (.+) service enabled$/) do |service|
  Server.register_services service.to_sym
end
