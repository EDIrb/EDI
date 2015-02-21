Given(/^a server is running with the (.+) service enabled$/) do |service|
  Server.register_services service.gsub(" ", "_").to_sym
end
