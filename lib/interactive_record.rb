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

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    self.class.column_names.delete_if {|col| col == "id"}.join(", ")
  end


end
