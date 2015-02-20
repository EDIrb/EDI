class Server < Jarvis::Server
  # Use `register_services` to enable services in your Jarvis Bot. Available built-in services are:
  # :dice, :eightball, :fact, :giphy
  # You can make your own services with `jarvis generate service my_service`
  register_services :fact
end
