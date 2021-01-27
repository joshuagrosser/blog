# Articles
class ArticlesController < ApplicationController

  def index
    render inline: \
      <<~HTML
        <%= form_tag('/auth/developer', method: 'post') do %>
          <button type='submit'>Login with Developer</button>
        <% end %>
        <form method='post' action='/auth/developer'>
          <button type='submit'>Login with Developer (no Authenticity token)</button>
        </form>
      HTML
  end

  def callback
    render inline: \
    <<~HTML
      <div>Welcome #{request.env['omniauth.auth']['uid']}</div>
    HTML
  end

  def failure
    render inline: \
    <<~HTML
      <div>You reached this due to an error in OmniAuth</div>
      <div>Strategy: #{params['strategy']}</div>
      <div>Message: #{params['message']}</div>
    HTML
  end

end
