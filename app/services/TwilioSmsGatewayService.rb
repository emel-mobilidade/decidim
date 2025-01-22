class TwilioSmsGatewayService
  attr_reader :mobile_phone_number, :code, :context
  
  def initialize(mobile_phone_number, code, context = {})
    @mobile_phone_number = mobile_phone_number
    @code = code
    @context = context
  end

  def client
    @client ||= Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end
  
  def deliver_code
    client.messages.create(
      body: I18n.t('twilio_sms_gateway_service.deliver_code.body', code:, organization: organization_name),
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: mobile_phone_number
    )
  end

  def organization_name
    context[:organization].name
  end
end