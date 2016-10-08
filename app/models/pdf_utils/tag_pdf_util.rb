module PdfUtils::TagPdfUtil
  # 虚拟属性，存放伸入一览选中的是哪些申请者
  attr_accessor :feign_attr

  def context! context = ''

      ERB.new(context).result binding

  end

  def get_tag_list
    tag_list = []
    self.order_tags.each do |order_tag|
      order_tag.order.items.each do |item|
        item.number.times do |i|
          tag_list << [order_tag.order.name, item.name, item.width, item.height, item.number]
        end
      end
    end
    list_html = "<tr class='tag_tr'>"
    tag_list.each_with_index do |tag, index|
      list_html += "<td class='tag_td'>#{tag[0]}<br/>#{tag[1]}<br/>#{tag[2]}×#{tag[3]}×#{tag[4]}</td>"
      list_html += "</tr><tr class='tag_tr'>" if (index + 1) % 4 == 0
      list_html += "</tr>" if index + 1 == tag_list.size
    end
    pp list_html
    list_html
  end

end
