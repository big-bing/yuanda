module PdfUtils::OrderPdfUtil
  # 虚拟属性，存放伸入一览选中的是哪些申请者
  attr_accessor :feign_attr

  def context! context = ''

      ERB.new(context).result binding

  end

  def tpl_get_list
    list_html = ''
    self.items.each do |item|
      list_html += <<-EOF
        <tr>
            <td>#{item.name}</td>
            <td width="13%">#{item.width}</td>
            <td width="13%">#{item.height}</td>
            <td>#{item.number}</td>
            <td>#{item.size}</td>
            <td>#{item.price}</td>
            <td>#{item.amout}</td>
        </tr>
      EOF
    end
    list_html
  end

  def tpl_get_number
    self.number
  end

  def tpl_get_size
    self.size
  end

  def tpl_get_amout
    self.amout
  end

  def tpl_get_total_amout
    self.total_amout
  end

  def tpl_get_capital_total_amout
    self.capital_total_amout
  end

  def tpl_get_prepaid_amout
    self.prepaid_amout
  end

  def tpl_get_rest_amout
    self.rest_amout
  end

end
