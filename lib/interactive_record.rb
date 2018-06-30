require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord #will be superclass to student

  def self.table_name
    #table name is class name, lowercase and pluralized(active_support/inflector?)
    self.to_s.downcase.pluralize
  end

  def self.column_names
    #column names are the column labels from sql table. Need table>columns>names
    #bing db for columns ...PRAGMA?
    DB[:conn].results_as_hash = true
    sql = "pragma table_info('#{table_name}')"

    table_info = DB[:conn].execute(sql)
    column_names = []
    table_info.each do |row|
      column_names << row["name"]
    end
    column_names.compact #eliminate nil entries
  end

end
