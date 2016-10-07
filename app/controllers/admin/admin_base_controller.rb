class Admin::AdminBaseController < ApplicationController

  private

  # 保留两位小数
  def number_to_capital_zh(strno=nil)

    cCha = [
      ['零元','零拾','零佰','零仟','零万','零亿','亿万','零零零','零零','零万','零亿','亿万','零元'],
      ['元','零','零','零','万','亿','亿','零','零','万','亿','亿','元']
    ]

    strno = strno.to_s.split(".")
    return "零元" if strno.blank?
    if strno.size > 1
       result = (change_unit(strno.first.split("").reverse,"first").reverse  + change_unit(strno.last.to_f.round(2).split(""),"last")).join("")
    else
       result = (change_unit(strno.first.split("").reverse,"first").reverse).join("") + "整"
    end
    for m in 0..12
      result_number = result.gsub(cCha[0][m], cCha[1][m])
    end
    result_number

  end

  def change_unit(aske_no,unit)
    unit = %w(角 分)  if unit == "last"
    unit = %w(元 拾 佰 仟 万 拾 佰 仟 亿 拾 佰 仟 万 拾 佰 仟)  if unit == "first"
    number = {"0"=>"零","1"=>"壹","2"=>"贰","3"=>"叁","4"=>"肆","5"=>"伍","6"=>"陆","7"=>"柒","8"=>"捌","9"=>"玖"}
    result = []
    aske_no.each_with_index do |no,index|
      result << number[no] + unit[index]
    end
    result
  end

end
