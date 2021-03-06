module SalesEngine
  class InvoiceItem < Record
    attr_accessor :item_id, :invoice_id, :quantity, :unit_price

    def initialize(attributes = {})
      super
      self.item_id = attributes[:item_id].to_i
      self.invoice_id = attributes[:invoice_id].to_i
      self.quantity = attributes[:quantity].to_i
      self.unit_price = convert_to_big_decimal(attributes[:unit_price])
    end

    def invoice
      @invoice ||= Database.instance.find_by("invoices", "id", self.invoice_id)
    end

    def item
      @item ||= Database.instance.find_by("items", "id", self.item_id)
    end

    def total
      quantity * unit_price
    end

    def sold?
      invoice.paid?
    end

    def self.random
      DATABASE.get_random_record("invoiceitems")
    end

    def self.find_by_id(id)
      DATABASE.find_by("invoiceitems", "id", id)
    end

    def self.find_by_item_id(item_id)
      DATABASE.find_by("invoiceitems", "item_id", item_id)
    end

    def self.find_by_invoice_id(invoice_id)
      DATABASE.find_by("invoiceitems", "invoice_id", invoice_id)
    end

    def self.find_by_unit_price(unit_price)
      DATABASE.find_by("invoiceitems", "unit_price", unit_price)
    end

    def self.find_by_quantity(quantity)
      DATABASE.find_by("invoiceitems", "quantity", quantity)
    end

    def self.find_by_created_at(time)
      DATABASE.find_by("invoiceitems", "created_at", time)
    end

    def self.find_by_updated_at(time)
      DATABASE.find_by("invoiceitems", "updated_at", time)
    end

    def self.find_all_by_id(id)
      DATABASE.find_all_by("invoiceitems", "id", id)
    end

    def self.find_all_by_item_id(item_id)
      DATABASE.find_all_by("invoiceitems", "item_id", item_id)
    end

    def self.find_all_by_invoice_id(invoice_id)
      DATABASE.find_all_by("invoiceitems", "invoice_id", invoice_id)
    end

    def self.find_all_by_unit_price(unit_price)
      DATABASE.find_all_by("invoiceitems", "unit_price", unit_price)
    end

    def self.find_all_by_quantity(quantity)
      DATABASE.find_all_by("invoiceitems", "quantity", quantity)
    end

    def self.find_all_by_created_at(time)
      DATABASE.find_all_by("invoiceitems", "created_at", time)
    end

    def self.find_all_by_updated_at(time)
      DATABASE.find_all_by("invoiceitems", "updated_at", time)
    end
  end
end