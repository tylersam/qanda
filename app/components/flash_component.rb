# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  attr_reader :message

  def initialize(alert_type:, message:, layout: :application)
    @alert_type = alert_type
    @message = message
    @layout = layout
  end

  def render?
    message.present?
  end

  def alert_class
    error_alert? ? 'alert-error' : 'alert-info'
  end

  def alert_icon
    if error_alert?
      # Circle with x inside
      'M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z'
    else
      # Circle with i inside
      'M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z'
    end
  end

  def container_location
    if @layout == :application
      'top-16'
    else
      'top-0'
    end
  end

  private

  def error_alert?
    @alert_type == :alert
  end
end
