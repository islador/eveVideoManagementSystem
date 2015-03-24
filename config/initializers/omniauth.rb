module OmniAuth
  module Strategies
    autoload :Eve, Rails.root.join('lib', 'strategies', 'eve_crest_sso')
  end
end
