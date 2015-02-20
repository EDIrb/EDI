Given(/^the environment is configured for Giphy$/) do
  stub_env("GIPHY_API_VERSION" => "v1", "GIPHY_API_KEY" => "key")
end
