class Message < ActiveRecord::Base
  belongs_to :contact
  before_create :send_message


private

  def send_message
    begin
      response = RestClient::Request.new(
        :method => :post,
        :url =>"https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
        :user => ENV['TWILIO_ACCOUNT_SID'],
        :password => ENV['TWILIO_AUTH_TOKEN'],
        :payload => {:Body => body,
                       :From => from,
                       :To => to }
        ).execute

    rescue RestClient::BadRequest => error
       message = JSON.parse(error.response)['message']
       errors.add(:To, message)
      false
    end
  end
end
