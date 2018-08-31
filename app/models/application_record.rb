class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # use for datatables. if there is params then disable default order scope
  def self.dt_order(params)
    if params['order'].present? && params['order']['0']['column'].present?
      self.unscoped
    else
      self
    end
  end

  def boolean?(value)
    value.is_a?(TrueClass) || value.is_a?(FalseClass)
  end
end
