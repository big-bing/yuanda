# 2010/10/23 pdfutil的依赖说明(rsh)：
# 1，PDFKit -> gem 'pdfkit', '~> 0.6.2'
# 2，wkhtmltopdf ↓
# 2.1 Install by hand (recommended): https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF
# 2.1.1 path no space and set PATH
# 2.2 Try using the wkhtmltopdf-binary gem (mac + linux i386)：gem install wkhtmltopdf-binary
# 3，Configuration -> config/initializers/pdfkit.rb

class PdfUtil
  #DIR_PATH = File.join Rails.root, 'temp', 'pdf'
  # DIR_PATH = APP_CONFIG[:export_apply_path]
  DIR_PATH = "#{Rails.root.to_s}/tmp/pdf/"
  attr_accessor :kit, :template

  # 为了渲染html，这里的变量是根据html的变量而来的。
  # 2014/10/23 by rsh
  def self.config template, page_flag=nil
    pdf = PdfUtil.new
    pdf.template = template
    pdf.kit      = pdf.pdf_kit page_flag
    pdf
  end

  # 渲染 html
  # 2014/10/23 by rsh
  def pdf_kit page_flag
    raise 'No Context to PDF!!' if template.blank?
    template.gsub!(".com:/",".com/") # strip out bad attachment_fu URLs
    template.gsub!( /src=["']+([^:]+?)["']/i ) do |matched|   # re-route absolute paths
      matched =~ /src=["']+([^:]+?)["']/i # TODO
      matched = "src=\"#{Rails.public_path}/#{$1}\""
    end
    # Remove asset ids on images with a regex
    template.gsub!( /src=["'](\S+\?\d*)["']/i ) do |matched|
      matched =~ /src=["'](\S+\?\d*)["']/i
      matched = "src=\"#{$1.split('?').first}\""
    end
    # 是否用PDF插件显示页码, 这里只针对名片出力，项目明细走的是 else
    if page_flag.present?
      PDFKit.new template,{:footer_center => '[page]/[topage]',:page_size => 'A4'}
    else
      PDFKit.new template,{:page_size => 'A4'}
    end
  end

  # 转换成pdf流，用send_data吐出
  # 2014/10/23 by rsh
  def to_pdf
    kit.to_pdf
  end

  # 保存 pdf 文件
  # 2014/10/23 by rsh
  def to_file path, name
    raise 'No such path or name when save pdf.' if path.blank? or name.blank?
    path = File.join DIR_PATH, path
    FileUtils.mkdir_p path unless File.exist? path
    File.open(File.join(path, name) , 'wb') do |f|
      f.write(to_pdf) #写入临时文件
      f.close
    end
    path
  end

end
