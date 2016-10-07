class Admin::TagsController < Admin::AdminBaseController

  def index
    @tags = Tag.all.page(params[:page]).per(50).order("tags.id desc")
  end

  def search
    con = Tag.getConn params
    @tags = Tag.where(con).all.page(params[:page]).per(50).order("tags.id desc")
    render :index
  end

  def destroy
    @tag = Tag.find_by_id(params[:id]);
    if @tag.destroy
      flash[:notice] = '删除成功'
    else
      flash[:notice] = '删除失败'
    end
    redirect_to action: :index
  end

  # 下载pdf
  def download_pdf
    html = ''
    file_name = UUIDTools::UUID.random_create
    tag = Tag.find_by_id(params[:id])
    # html = get_context(params, article) if article.present?
    html = get_context tag
    if html.blank?
      flash[:notice] = "データが存在しません。"
      return redirect_to admin_tags_path
    end
    pdf = PdfUtil.config(html, 'page')
    pdf.to_file("order", "#{file_name}.pdf")
    path = "#{Rails.root.to_s}/tmp/pdf/order/#{file_name}.pdf" rescue nil
    if path.blank?
      flash[:notice] = t('no_data')
      return redirect_to admin_tags_path unless path
    end
    send_file(path, filename: encode_file_name("tag.pdf"))
  end

  private

  # 获取模板以及将模板中需要动态显示数据的地方，把数据获取到
  def get_context tag
    template = get_template
    return tag.context!(template)
  end

  # 获取模板
  def get_template
    template = ''
    tmp = File.new("#{Rails.root.to_s}/public/files/tag_list.html").read
    template += tmp
    template
  end

end
