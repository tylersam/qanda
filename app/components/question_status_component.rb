# frozen_string_literal: true

class QuestionStatusComponent < ViewComponent::Base
  def initialize(question:)
    @question = question
  end

  def badge_classes
    [
      'badge',
      { 'badge-warning badge-outline': question.unanswered? },
      { 'badge-secondary': question.answered? },
      { 'badge-success': question.solved? },
    ]
  end

  def status
    question.status.humanize
  end

  private

  attr_reader :question
end
