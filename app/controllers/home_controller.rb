class HomeController < ApplicationController
  def index
  end

  def convert

    rt = cgi_unescape_html(params[:input][:text]) if params[:CGIunescapeHTML].present?
    rt = cgi_unescape(params[:input][:text]) if params[:CGIunescape].present?
    rt = uri_decode(params[:input][:text]) if params[:URIdecode].present?
    rt = cgi_escape_html(params[:input][:text]) if params[:CGIescapeHTML].present?
    rt = cgi_escape(params[:input][:text]) if params[:CGIescape].present?
    rt = uri_encode(params[:input][:text]) if params[:URIencode].present?

    rt = base64_encode64(params[:input][:text]) if params[:BASE64encode64].present?
    rt = base64_decode64(params[:input][:text]) if params[:BASE64decode64].present?

    @result = rt
  end

  def cgi_unescape_html(value) 
    lines = []
    CGI.unescapeHTML(value).lines do |line|
      lines.push line.chomp.gsub(/\\/, '\\\\\\')
    end
    lines.join('\\n')
  end

  def cgi_unescape(value) 
    lines = []
    CGI.unescape(value).lines do |line|
      lines.push line.chomp.gsub(/\\/, '\\\\\\')
    end
    lines.join('\\n')
  end

  def uri_decode(value) 
    lines = []
    URI.decode(value).lines do |line|
      lines.push line.chomp.gsub(/\\/, '\\\\\\')
    end
    lines.join('\\n')
  end

  def cgi_escape_html(value)
    lines = []
    value.lines do |line|
      lines.push CGI.escapeHTML(line.chomp).gsub(/\\/, '\\\\\\')
    end
    lines.join('\\n')
  end

  def cgi_escape(value)
    lines = []
    value.lines do |line|
      lines.push CGI.escape(line.chomp).gsub(/\\/, '\\\\\\')
    end
    lines.join('\\n')
  end

  def uri_encode(value)
    lines = []
    value.lines do |line|
      lines.push URI.encode(line.chomp).gsub(/\\/, '\\\\\\')
    end
    lines.join('\\n')
  end

  def base64_encode64(value)
    Base64.encode64(value).lines.map{|l|l.chomp}.join('\\n')
  end

  def base64_decode64(value)
    Base64.decode64(value).lines.map{|l|l.chomp}.join('\\n')
  end
end
