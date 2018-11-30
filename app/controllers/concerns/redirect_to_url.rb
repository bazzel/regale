require 'active_support/concern'

# The role of the user determines which page to redirect to
# when a user has been saved or cancelled.
# This module handles that by providing
# a view helper `redirect_to_url_field` that can be added to a form
# `redirect_to_url` that can be used as an argument for `link_to`.
# When a form, containing `redirect_to_url_field` is submitted,
# the controller action can use `redirect_to_param` to get
# the proper value from the params and use it to redirect.
#
# @example:
# # view
# = form_with model: Post.first do |f|
#   = f.redirect_to_url_field
#   ...
#   = link_to 'Cancel', redirect_to_path
# # =>
#  <form action="/posts/1" method="post" data-remote="true">
#    <input type="hidden" name="redirect_to_url" id="redirect_to_url" value="http://example.com/some/path/i/came/from">
#    ...
#    <ahref="/some/path/i/came/from">Cancel</a>
#
# # controller:
#
# def update
#   ..
#   redirect_to redirect_to_param, notice: 'You did it!'
# end
module RedirectToUrl
  extend ActiveSupport::Concern

  included do
    helper_method :redirect_to_url, :redirect_to_url_field, :redirect_to_path
  end

  def redirect_to_param
    params.fetch redirect_to_name
  end

  def redirect_to_url
    @redirect_to_url ||= begin
                           (request.referer == request.original_url) ? root_url : request.referer
                         end
  end

  def redirect_to_url_field
    view_context.hidden_field_tag redirect_to_name, redirect_to_url
  end

  def redirect_to_path
    uri = URI(redirect_to_url)
    uri.path
  end

  private
  def redirect_to_name
    :redirect_to_url
  end
end
