class TwilioGatewayService
  attr_reader :mobile_phone_number, :code, :context
  
  def initialize(mobile_phone_number, code, context = {})
    @mobile_phone_number = mobile_phone_number
    @code = code
    @context = context
  end
  
  def deliver_code
    # Actual code to deliver the code
    true
  end
end