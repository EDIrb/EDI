class Core < EDI::Core
  # Use `register_services` to enable services in your EDI Bot. Available built-in services are:
  # :dice, :eightball, :fact, :giphy, :i_heart_quotes, :img_flip, :tweet_that, :weather
  # You can make your own services with `edi generate service my_service`
  register_services :fact
end
