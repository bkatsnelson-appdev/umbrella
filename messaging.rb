require "twilio-ruby"

# Get your credentials from your Twilio dashboard, or from Canvas if you're using mine
twilio_sid = "AC28922e0822d827ee29834fe1dc6f681e"
twilio_token = "b7cfcdffa1800ad47260ec5c04da6975"
twilio_sending_number = "+13126636198"

# Create an instance of the Twilio Client and authenticate with your API key
twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

# Craft your SMS as a Hash literal with three keys
sms_info = {
  :from => twilio_sending_number,
  :to => "+18478679419", # Put your own phone number here if you want to see it in action
  :body => "It's going to rain today — take an umbrella!"
}

# Send your SMS!
twilio_client.api.account.messages.create(sms_info)
