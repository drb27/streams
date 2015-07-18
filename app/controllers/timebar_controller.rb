require 'rmagick'

class TimebarController < ApplicationController

  def testBlob
    width=70
    height=8
    percentage = Integer(params[:pc])
    img = Magick::Image.new width, height
    img.format = "PNG"
    gc = Magick::Draw.new

    # Last pixel of time gone
    boundary = width * percentage / 100
    
    # Time gone
    gc.stroke = 'red'
    gc.fill = 'red'
    gc.rectangle 0, 0, boundary, height
    gc.draw img
    
    # Time left to go
    gc = Magick::Draw.new
    gc.stroke = 'green'
    gc.fill = 'green'
    gc.rectangle boundary+1, 0, width, height
    gc.draw img
    send_data img.to_blob, :type => 'image/png', :disposition => 'inline'
  end

end
