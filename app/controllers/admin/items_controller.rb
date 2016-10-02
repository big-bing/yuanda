class Admin::ItemsController < Admin::AdminBaseController

  def create
    @item = Item.new get_item_params
    @item_form_number = params[:item][:item_form_number]
    @save_flag = false
    if @item.valid?
      @item.size = @item.width * @item.height / 1000000.to_f
      @item.amout = @item.size * @item.price * @item.number + @item.punch_count * @item.punch_price + @item.dig_angle_count * @item.dig_angle_price
      Item.transaction do
        begin
          @item.save
          order = Order.find_by_id(@item.order_id)
          order.amout = order.amout.to_f + @item.amout
          order.total_amout = order.amout.to_i
          order.number = order.number.to_i + @item.number.to_i
          order.size = order.size.to_f + @item.size.to_f
          order.save
          @save_flag = true
        rescue Exception => e
          @save_flag = false
        end
      end
    end
  end

  def update

  end

  def destroy
    @save_flag = false
    @save_flag = true
    @item_form_number = params[:item][:exist_item_form_number]
  end

  private

  def get_item_params
    params.fetch(:item, {}).permit(
      :order_id,
      :name,
      :width,
      :height,
      :number,
      :price,
      :punch_count,
      :punch_price,
      :dig_angle_count,
      :dig_angle_price,
    );
  end

end
