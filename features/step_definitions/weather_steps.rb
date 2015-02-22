Given(/^a default location of (\d+)$/) do |arg1|
  stub_env("DEFAULT_LOCATION" => "43204")
end
