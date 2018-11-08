module FontAwesomeHelper
  # See https://fontawesome.com/v4.7.0/icons/
  # for icons you can use.
  # Pass the name of the icon to the helper method.
  #
  # @example
  #   fa_icon('cutlery')
  #   #=> '<span class="fa fa-cutlery"></span>
  def fa_icon(icon)
    FontAwesome::Icons.send(icon)
  end
end
