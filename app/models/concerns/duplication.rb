module Duplication
  extend ActiveSupport::Concern

  def dup_with(hash = {})
    dup_attr = attributes.deep_dup
    dup_attr.merge!(hash.stringify_keys)
    dup_attr.delete(self.class.primary_key)
    self.class.create(dup_attr)
  end
end