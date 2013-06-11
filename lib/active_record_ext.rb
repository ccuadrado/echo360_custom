require 'active_record'

module ActiveRecordExt
  
  def update_create(obj, params)
    obj.nil? ? self.create(params) : self.update(obj.id, params)
  end

end
