Product.class_eval do
  def can_be_compared?
    !self.taxons.to_a.find{|t| t.is_comparable? }.nil?
  end
end
