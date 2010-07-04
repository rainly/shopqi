class ProductsController < InheritedResources::Base
  layout nil, :only => [ :new , :create]
  respond_to :js, :only => [ :new, :create]
  actions :new, :create

  # 提示消息
  def interpolation_options
     { :cn_resource_name => resource_class.model_name.human }
  end
end