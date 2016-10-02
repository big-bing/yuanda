module PdfUtils::OrderPdfUtil
  # 虚拟属性，存放伸入一览选中的是哪些申请者
  attr_accessor :feign_attr

  def context! context = ''

      ERB.new(context).result binding

  end

  def tpl_apply_name
    # event = Event.select("events.name").where([' events.id = ? ', self.event_id]).first
    # event.name rescue ''
    self.name
  end

  def tpl_event_name
    '22'
  end

  def tpl_apply_no
    '33'
  end

  def tpl_apply_total_amount
    '44'
  end

  def tpl_apply_url
    '55'
  end

  def tpl_apply_email
    '66'
  end

  def tpl_get_list
    list_html = <<-EOF
      <tr>
          <td>12mm钢化贴纸玉砂</th>
          <td width="13%">700</td>
          <td width="13%">1420</td>
          <td>3</td>
          <td>2.98</td>
          <td>150</td>
          <td>447.30</td>
      </tr>
    EOF
    list_html
  end

end
