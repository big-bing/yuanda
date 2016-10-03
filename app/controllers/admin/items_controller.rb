class Admin::ItemsController < Admin::AdminBaseController

  def create
    @item = Item.new get_item_params
    save_status = '1'
    if @item.valid?
      @item.size = @item.width * @item.height / 1000000.to_f
      @item.amout = @item.size * @item.price * @item.number + @item.punch_count * @item.punch_price + @item.dig_angle_count * @item.dig_angle_price
      Item.transaction do
        begin
          @item.save
          order = Order.find_by_id(@item.order_id)
          order.amout = order.amout.to_f + @item.amout.to_f
          order.total_amout = order.amout.to_i
          order.number = order.number.to_i + @item.number.to_i
          order.size = order.size.to_f + @item.size.to_f
          order.save
          save_status = '2'
        rescue Exception => e
          save_status = '3'
        end
      end
    end
    render json: { save_status: save_status, item: @item.to_json }
  end

  def update
    @item = Item.find_by_id(params[:id])
    old_size = @item.size
    old_amout = @item.amout
    old_number = @item.number
    save_status = '1'
    Item.transaction do
      begin
        @item.update_attributes get_item_params
        @item.size = @item.width * @item.height / 1000000.to_f
        @item.amout = @item.size * @item.price * @item.number + @item.punch_count * @item.punch_price + @item.dig_angle_count * @item.dig_angle_price
        @item.save
        order = Order.find_by_id(@item.order_id)
        order.amout = order.amout.to_f + @item.amout.to_f - old_amout.to_f
        order.total_amout = order.amout.to_i
        order.number = order.number.to_i + @item.number.to_i - old_number.to_i
        order.size = order.size.to_f + @item.size.to_f - old_size.to_f
        order.save
        save_status = '2'
      rescue Exception => e
        save_status = '3'
      end
    end
    render json: { save_status: save_status, item: @item.to_json }
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    delete_status = '1'
    if @item.present?
      Item.transaction do
        begin
          order = Order.find_by_id(@item.order_id)
          order.amout = order.amout.to_f - @item.amout.to_f
          order.total_amout = order.amout.to_i
          order.number = order.number.to_i - @item.number.to_i
          order.size = order.size.to_f - @item.size.to_f
          if order.save
            @item.destroy
          end
          delete_status = '2'
        rescue Exception => e
          pp e
          delete_status = '3'
        end
      end
    end
    render json: { delete_status: delete_status }
  end

  private

  def get_item_params
      params.permit(
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
