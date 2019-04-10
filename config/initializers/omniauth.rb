Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'],
      { :image_size => 'original', :authorize_params => { :lang => 'ja' } }
    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
      { display: 'page', image_size: 'normal' }
end
