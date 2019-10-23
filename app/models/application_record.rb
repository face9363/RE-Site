class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def restricted_data(obj, column_array)
    result_json = {}
    column_array.each do |column|
      result_json[column] = obj[column]
    end
    return result_json
  end
end
