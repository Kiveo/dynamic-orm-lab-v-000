require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord #will be superclass to student

  #table_name
  def table_name
    #table name is class name, lowercase and pluralized(active_support/inflector?)
    self.to_s.downcase.pluralized
  end

end
