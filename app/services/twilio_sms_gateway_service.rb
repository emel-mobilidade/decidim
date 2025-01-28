# frozen_string_literal: true

class TwilioSmsGatewayService
  attr_reader :mobile_phone_number, :code, :context

  def initialize(mobile_phone_number, code, context = {})
    @mobile_phone_number = mobile_phone_number
    @code = code
    @context = context
  end

  def client
    @client ||= Twilio::REST::Client.new(ENV.fetch("TWILIO_ACCOUNT_SID", nil), ENV.fetch("TWILIO_AUTH_TOKEN", nil))
  end

  def deliver_code
    client.messages.create(
      body: I18n.t("twilio_sms_gateway_service.deliver_code.body", code:, organization: organization_name),
      from: ENV.fetch("TWILIO_PHONE_NUMBER", nil),
      to: mobile_phone_number
    )
  rescue StandardError => e
    Rails.logger.error("Error sending SMS: #{e.message}")
    false
  end

  def organization_name
    context[:organization].name
  end
end
