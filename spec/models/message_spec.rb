require 'rails_helper'

describe Message, :vcr => true do
  it "doesn't save the message if twilio gives an error" do
    message = Message.new(:body => 'hi', :to => '1111111', :from => '+15034558610')
    message.save.should be false
  end

  it 'adds an error if the to number is invalid' do
    message = Message.new(:body => 'hi', :to => '1111111', :from => '+15034558610')
    message.save
    message.errors[:To].should eq ["The 'To' number 1111111 is not a valid phone number."]
  end
end
