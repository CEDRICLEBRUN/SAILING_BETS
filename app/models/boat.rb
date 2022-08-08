class Boat < ApplicationRecord
  has_many :bets
  has_many :results

  ultims = []
  imocas = []
  ocean_fifty = []
  class_40 = []
  rhum_multi = []
  rhum_mono = []
  Boat.all.each do |boat|
    case boat.category
    when "Ultim"
      ultims << "#{boat.name} - #{boat.skipper_last_name} #{boat.skipper_first_name}"
    when "IMOCA"
      imocas << "#{boat.name} - #{boat.skipper_last_name} #{boat.skipper_first_name}"
    when "Ocean Fifty"
      ocean_fifty << "#{boat.name} - #{boat.skipper_last_name} #{boat.skipper_first_name}"
    when "Class 40"
      class_40 << "#{boat.name} - #{boat.skipper_last_name} #{boat.skipper_first_name}"
    when "Rhum Mono"
      rhum_mono << "#{boat.name} - #{boat.skipper_last_name} #{boat.skipper_first_name}"
    when "Rhum Multi"
      rhum_multi << "#{boat.name} - #{boat.skipper_last_name} #{boat.skipper_first_name}"
    end
  end
  ULTIM = ultims
  IMOCA = imocas
  OCEANFIFTY = ocean_fifty
  CLASS40 = class_40
  RHUMMONO = rhum_mono
  RHUMMULTI = rhum_multi
end
