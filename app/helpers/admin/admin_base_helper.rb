module Admin::AdminBaseHelper

  #显示验证的提示信息
  #【引数】
  #【返回】
  #【注意】
  #【著作】common
  def error_messages_for(*params)
    options = params.extract_options!.symbolize_keys

    objects = Array.wrap(options.delete(:object) || params).map do |object|
      object = instance_variable_get("@#{object}") unless object.respond_to?(:to_model)
      object = convert_to_model(object)

      if object.class.respond_to?(:model_name)
        options[:object_name] ||= object.class.model_name.human.downcase
      end

      object
    end

    objects.compact!
    count = objects.inject(0) { |sum, object| sum + object.errors.count }

    unless count.zero?
      html = {}
      [:id, :class, :style].each do |key|
        if options.include?(key)
          value = options[key]
          html[key] = value unless value.blank?
        else
          html[key] = 'widget-box'  #html[key] = 'errorExplanation'
        end
      end
      options[:object_name] ||= params.first

      I18n.with_options :locale => options[:locale], :scope => [:activerecord, :errors, :template] do |locale|
        header_message = if options.include?(:header_message)
                           options[:header_message]
                         else
                           locale.t :header, :count => count, :model => options[:object_name].to_s.gsub('_', ' ')
                         end

        message = options.include?(:message) ? options[:message] : locale.t(:body)

        error_messages = objects.sum do |object|
          sort_show_error_msg(object).map do |msg|
            next if msg.blank?
            #content_tag(:li, msg)
            content_tag(:li, ('<i class="icon-remove red"></i>&nbsp;' + msg).html_safe)
          end

        end.join.html_safe

        contents = ''
        #contents << content_tag(options[:header_tag] || :h2, header_message) unless header_message.blank?
        unless header_message.blank?
          h5_html = content_tag(options[:header_tag] || :h5, header_message, class: 'smaller')
          #widget-header header-color-red
          contents << content_tag(:div, h5_html.html_safe, class: 'widget-header header-color-red2 widget-header-small')
        end
        #contents << content_tag(:p, message) unless message.blank?
        #contents << content_tag(:ul, error_messages)
        ul_html = content_tag(:ul, error_messages, class: 'list-unstyled spaced')
        div_html = content_tag(:div, ul_html.html_safe, class: 'widget-main')
        div_main = content_tag(:div, div_html.html_safe, class: 'widget-body-inner', style: 'display: block;')
        contents << content_tag(:div, div_main.html_safe, class: 'widget-body')

        content_tag(:div, contents.html_safe, html)
      end
    else
      ''
    end
  end

  #显示验证的提示信息
  #【引数】
  #【返回】
  #【注意】
  #【著作】common
  def sort_show_error_msg(obj)
    msg_arr = obj.errors.sort
    #去除隐藏字段
    hidden_attr = obj.class::HIDDEN_ATTRIBUTES rescue []
    msg_arr.delete_if { |key, val| hidden_attr.include?(key) } unless hidden_attr.blank?
    #排序
    hash_field_orders = obj.class::HUMANIZED_ATTRIBUTES_ORDERS rescue {}
    #未设置排序的字段排在最后
    max = hash_field_orders.size + 1
    unless hash_field_orders.blank?
      msg_arr = msg_arr.sort do |key_a, key_b|
        value_a = hash_field_orders.include?(key_a[0].to_sym) ? hash_field_orders.index(key_a[0].to_sym) : max
        value_b = hash_field_orders.include?(key_b[0].to_sym) ? hash_field_orders.index(key_b[0].to_sym) : max
        value_a <=> value_b
      end
    end
    full_messages= []
    #yak添加
    translated_label = obj.class::HUMANIZED_ATTRIBUTES rescue {}
    msg_arr.each do |attr, msg|
      next if msg.nil?
      if attr == 'bases'
        full_messages << msg
      else
        #label = as_(config.columns[attr].label) if config and config.columns[attr]
        #翻译field
        #yak添加
        label ||= translated_label[attr.to_sym]
        label ||= obj.class.human_attribute_name(attr)
        #full_messages << content_tag(:li,"#{label + " " + as_(msg)}")
        full_messages << "#{label + ' ' + msg}"
      end
    end
    full_messages
  end

  #【引数】active_menu({users: [:new, :create]})
  #【返回】
  #【注意】
  #【著作】by gb 2016-08-24
  def active_menu(container)
    controller = params[:controller].gsub('admin/', '')
    if (container[controller.to_s.to_sym].present? && container[controller.to_s.to_sym].include?(params[:action].to_s.to_sym)) ||
        (container.has_key?(controller.to_s.to_sym) && container[controller.to_s.to_sym].blank?)
      raw " class='active open'"
    else
      ''
    end
  end

  #【引数】
  #【返回】
  #【注意】
  #【著作】by gb 2016-08-24
  def get_title
    hash = normal_title_hash
    controller = params[:controller].gsub('admin/', '')
    if hash[controller.to_s.to_sym].present? && hash[controller.to_s.to_sym][params[:action].to_s.to_sym].present?
      '远大玻璃 - ' + hash[controller.to_s.to_sym][params[:action].to_s.to_sym]
    else
      '远大玻璃'
    end
  end

  #【引数】
  #【返回】
  #【注意】
  #【著作】by gb 2016-08-24
  def normal_title_hash
    {

        order:
        {
          index: '订单一栏',
          new: '新建订单'
        },

        home:
        {
            index: 'ダッシュボード'
        },
        customer_type:
        {
            index: '会員種別一覧'
        },
        price_ranks:
        {
            index: '価格ランク名一覧',
            search: '価格ランク名一覧',
            new: '価格ランク名新規作成',
            create: '価格ランク名新規作成',
            edit: '価格ランク名編集',
            update: '価格ランク名編集'

        },
        show_plans:
        {
            index: '表示プラン設定一覧',
            search: '表示プラン設定一覧',
            new: '表示プラン設定新規作成',
            create: '表示プラン設定新規作成',
            edit: '表示プラン設定編集',
            update: '表示プラン設定編集'
        },
        admins:
        {
            index: '管理者一覧',
            search: '管理者一覧',
            new: '管理者新規作成',
            create: '管理者新規作成',
            edit: '管理者編集',
            update: '管理者編集'

        },
        product_attributes:
        {
            index: '商品属性一覧',
            search: '商品属性一覧',
            new: '商品属性新規作成',
            create: '商品属性新規作成',
            edit: '商品属性編集',
            update: '商品属性編集'

        },
        shipping_pattens:
        {
            index: '送料一覧',
            search: '送料一覧',
            new: '送料新規作成',
            create: '送料新規作成',
            edit: '送料編集',
            update: '送料編集'

        },
        discounts:
        {
            index: 'クーポン一覧',
            search: 'クーポン一覧',
            new: 'クーポン新規作成',
            create: 'クーポン新規作成',
            edit: 'クーポン編集',
            update: 'クーポン編集'

        },
        customers:
        {
            index: '利用者一覧',
            search: '利用者一覧',
            new: '利用者新規作成',
            create: '利用者新規作成',
            edit: '利用者編集',
            update: '利用者編集'

        },
        corporation_customers:
        {
            index: '中間卸一覧',
            search: '中間卸一覧',
            new: '中間卸新規作成',
            create: '中間卸新規作成',
            edit: '中間卸編集',
            update: '中間卸編集'

        },
        logistics:
            {
                all: '全ての一覧',
                result: '出荷済み一覧',
                index: '未出荷一覧',
                search: '未出荷一覧',
                edit: "出荷編集",
                update: '出荷編集'

            }
    }
  end

  #【引数】
  #【返回】
  #【注意】
  #【著作】by sjs 20160909
  def currency_format(v,unit = "￥")
    v = 0 unless v.present?
    number_to_currency(v, :unit => unit)
  end
end
