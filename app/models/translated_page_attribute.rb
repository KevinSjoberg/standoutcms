class TranslatedPageAttribute < ActiveRecord::Base
  belongs_to :page

  # creates or updates the attribute
  # rails 2.3.11 failed to handle find_or_create_by
  def self.push(page_id, language_short_code, key, value)
    attr = TranslatedPageAttribute.find(:first, :conditions => ["page_id = ? AND language_short_code = ? AND attribute_name = ?", page_id, language_short_code, key])
    if attr
      attr.update_attribute(:attribute_value, value)
    else
      TranslatedPageAttribute.create(:page_id => page_id, :language_short_code => language_short_code, :attribute_name => key, :attribute_value => value)
    end
  end
end
