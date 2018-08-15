require 'uri'
class Item < ApplicationRecord
  belongs_to :list, optional: true

  def preview
    if url.present? ?
      object = LinkThumbnailer.generate(url) : ""
      image = object.images.first.src.is_a?(String)? object.images.first.src : "http://res.cloudinary.com/dgccrihdr/image/upload/v1534330912/no-preview.png"
      description = object.description.truncate(100, separator: /\s/) + "..."
      title = object.title
      url_root = object.url.host.upcase
      return image, description, title, url, url_root
    end
  end

  def url
    # methode qui va trouver une url dans le titre. si pas d'url, alors ca renvoit nil
    URI.extract(name).first
  end
end
