class ApplicationSerializer < ActiveModel::Serializer
  attributes :id, :url

  def anchor
    [object.class.name.downcase, object.id].join('-')
  end
end
