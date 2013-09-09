module Duplication
  extend ActiveSupport::Concern

  def dup_with!(hash)
    # get a copy of the source object's attributes
    dup_attr = attributes

    # merge in hash
    dup_attr.merge!(hash.stringify_keys)

    # don't allow id or created_at to be duped
    dup_attr.delete(self.class.primary_key)
    dup_attr.delete("created_at")
    dup_attr.delete("updated_at")

    self.class.create!(dup_attr)
  end
end