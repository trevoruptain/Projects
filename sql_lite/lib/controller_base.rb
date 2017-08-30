require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'You can\'t double render' if self.already_built_response?
    @res.status = 302
    @res['Location'] = url
    @already_built_response = true
    session.store_session(@res)
    # flash.store_flash(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'You can\'t double render' if self.already_built_response?
    @res.write(content)
    @res['Content-Type'] = content_type
    @already_built_response = true
    session.store_session(@res)
    # flash.store_flash(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    path = File.dirname(__FILE__)
     filename = File.join(
       path, "..",
       "views", self.class.name.underscore, "#{template_name}.html.erb"
     )

     html_cont = File.read(filename)

     render_content(
       ERB.new(html_cont).result(binding),
       "text/html"
     )
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    if req.request_method != "GET" && protect_from_forgery
      check_authenticity_token
    else
      form_authenticity_token
    end

    self.send(name)
    render(name) unless already_built_response?
    nil
  end

  def form_authenticity_token
    @token ||= generate_authenticity_token
    res.set_cookie('authenticity_token', value: @token, path: '/')
    @token
  end

  protected

  def self.protect_from_forgery
    @@protect_from_forgery = true
  end

  private

  attr_accessor :already_built_response

  def controller_name
    self.class.to_s.underscore
  end

  def protect_from_forgery?
    @@protect_from_forgery
  end

  def check_authenticity_token
    cookie = @req.cookies["authenticity_token"]
    unless cookie && cookie == params["authenticity_token"]
      raise "Invalid authenticity token"
    end
  end

  def generate_authenticity_token
    SecureRandom.urlsafe_base64(16)
  end
end
