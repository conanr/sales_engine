require 'csv'
require 'singleton'
require './lib/sales_engine/merchant'
require './lib/sales_engine/item'
require './lib/sales_engine/invoice'
require './lib/sales_engine/customer'
require './lib/sales_engine/transaction'
require './lib/sales_engine/invoice_item'

class Database
  include Singleton
  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}
  attr_accessor :merchants, :items, :invoices, :transactions, 
                :customers, :invoiceitems

  def initialize
    clear_all_data
  end

  def clear_all_data
    self.merchants = []
    self.items = []
    self.invoices = []
    self.transactions = []
    self.customers = []
    self.invoiceitems = []
  end

  def get_random_record(class_name)
    self.send(class_name)[rand(self.send(class_name).count)]
  end

  def load_merchants_data(filename)
    @file = CSV.open(filename, CSV_OPTIONS)
    self.merchants = @file.collect {|line| Merchant.new(line) }
  end

  def load_items_data(filename)
    @file = CSV.open(filename, CSV_OPTIONS)
    self.items = @file.collect {|line| Item.new(line) }
  end

  def load_invoices_data(filename)
    @file = CSV.open(filename, CSV_OPTIONS)
    self.invoices = @file.collect {|line| Invoice.new(line) }
  end

  def add_to_list(thing)
    self.send(thing.class.to_s.downcase+"s") << thing
  end

  def find_by(class_name,attribute,search_value)   
    self.send(class_name).find { |record| 
      attribute_value = record.send(attribute)
      if attribute_value.is_a?(String)
        attribute_value.downcase == search_value.downcase
      else
        attribute_value == search_value
      end }
  end

  def find_all_by(class_name,attribute,search_value)   
    self.send(class_name).find_all { |record| 
      attribute_value = record.send(attribute)
      if attribute_value.is_a?(String)
        attribute_value.downcase == search_value.downcase
      else
        attribute_value == search_value
      end }
  end

  def find_all_items_by_merchant_id(id)
    item_list = []
    self.items.each do |item| 
      if item && item.merchant_id && item.merchant_id == id
        item_list << item
      end
    end
    item_list.sort_by { |item| item.merchant_id }
  end

  def find_all_invoices_by_merchant_id(id)
    invoice_list = []
    self.invoices.each do |invoice| 
      if invoice && invoice.merchant_id && invoice.merchant_id == id
        invoice_list << invoice
      end
    end
    invoice_list.sort_by { |invoice| invoice.merchant_id }
  end
end