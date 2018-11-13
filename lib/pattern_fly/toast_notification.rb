# frozen_string_literal: true

module PatternFly
  class ToastNotification
    PF_ALERT_TYPES = %i[success info warning danger].freeze
    delegate :flash, :raw, :content_tag, :safe_join, to: :@template

    ICONS = {
      success: 'ok',
      info: 'info',
      warning: 'warning',
      danger: 'error'
    }.freeze

    attr_reader :options, :template

    def initialize(options, template)
      @options = options
      @template = template
    end

    def render
      safe_join flash_messages
    end

    private

    def flash_messages
      flash.map do |type, message|
        # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
        next if message.blank?
        next if (pf_type = pf_type(type)).nil?

        flash_message(Array(message), pf_type)
      end.flatten.compact
    end

    def pf_type(type)
      pf_type = case type.to_sym
                when :notice then :success
                when :alert, :error then :danger
                else type.to_sym
                end

      PF_ALERT_TYPES.include?(pf_type) ? pf_type : nil
    end

    def flash_message(messages, type)
      icon        = icon(type)
      tag_options = tag_options(type)

      messages.delete_if(&:nil?).map do |msg|
        content_tag(:div, close_button + icon + msg, tag_options)
      end
    end

    def icon(type)
      Icons.send(ICONS[type])
    end

    def tag_options(type)
      tag_class = options.extract!(:class)[:class]
      {
        class: "toast-pf toast-pf-max-width toast-pf-top-right alert alert-#{type} alert-dismissable #{tag_class}"
      }.merge(options)
    end

    def close_button
      @close_button ||= begin
                          content_tag(:button, type: 'button', class: 'close', 'data-dismiss' => 'alert') do
                            Icons.close
                          end
                        end
    end
  end
end
