require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord #will be superclass to student

  def self.table_name
    #table name is class name, lowercase and pluralized(active_support/inflector?)
    self.to_s.downcase.pluralize
  end

  def self.column_names
    #set hash result
    DB[:conn].results_as_hash = true
    #PRAGMA column info, then assign execution as variable data info
    sql = "PRAGMA table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    column_names = table_info.collect{|row| row["name"]}.compact #compact to avoid nil values
  end

  def initialize(options={}) #set options as a hash, then assign key-value pairs
    options.each do |key, value|
      self.send("#{key}", value)
    end
  end

end
