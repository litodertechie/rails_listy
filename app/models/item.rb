require 'uri'
class Item < ApplicationRecord
  belongs_to :list, optional: true

  def preview
    if url.present? ?
      object = LinkThumbnailer.generate(url) : ""
      # image = object.images.first.src if object.images.first.src.is_a?(String) else
      image = object.images.first.src.is_a?(String)? object.images.first.src : "http://res.cloudinary.com/dgccrihdr/image/upload/v1534261028/question_mark.jpg"
      description = object.description
      title = object.title
      return image, description, title, url
    end
  end

  def url
    # methode qui va trouver une url dans le titre. si pas d'url, alors ca renvoit nil
    URI.extract(name).first
  end
end
