# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Add the CCP vendor folder to the application's assets precompile path.
Rails.application.config.assets.paths.push("#{Rails.root.join("vendor","CCP").to_s}")
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Precompile CCP vendor folder
Rails.application.config.assets.precompile += %w( EVE_SSO_Login_Buttons_Large_Black.png )
