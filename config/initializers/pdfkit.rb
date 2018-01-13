# PDFKit.configure do |config|
  # config.wkhtmltopdf = '/Users/bigbing/.rvm/gems/ruby-2.3.0/bin/wkhtmltopdf'
  # config.default_options = {
  #   :page_size => 'Legal',
  #   :print_media_type => true
  # }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
# end

class PDFKit
  def command(path = nil)
    args = [executable]
    args += @options.to_a.flatten.compact
    #pp @options
    #args << '--footer-center' # Get HTML from stdin
    #args << '[page]/[topage]'
    if @source.html?
      args << '-' # Get HTML from stdin
    else
      args << @source.to_s
    end
    #pp args
    args << (path || '-') # Write to file or stdout
    #pp args
    args.join " "
  end

  def to_file path
    File.open(path, 'wb') do |f|
      f.write(to_pdf)
      f.close
    end
  end

end
PDFKit.configure do |config|
  # config.wkhtmltopdf = '/Users/bigbing/.rvm/gems/ruby-2.3.0/bin/wkhtmltopdf' # 'C:\\wkhtmltopdf\\bin\\wkhtmltopdf.exe'
  # config.wkhtmltopdf = 'D:\\wkhtmltopdf\\bin\\wkhtmltopdf.exe'
  # config.wkhtmltopdf = '/Users/bigbing/.rvm/gems/ruby-2.3.0/bin/wkhtmltopdf'
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  # config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  config.default_options = {
    # :page_size => 'A4',
    :page_width => 210,
    :page_height => 300,
    :margin_top => 0,
    :margin_bottom => 0,
    :margin_left => 0,
    :margin_right => 0,
    :print_media_type => true,
  }
end
