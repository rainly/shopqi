# encoding: utf-8
class CategoriesController < InheritedResources::Base
  layout nil
  actions :index, :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  respond_to :json, :only => [:index]

  create! do |format|
    format.js { render :nothing => true }
  end

  update! do |format|
    format.js { render :nothing => true }
  end

  destroy! do |format|
    format.js { render :nothing => true }
  end

  def index
    @result = params[:id].blank? ? Category.roots : Category.find(params[:id]).children
    render :json => get_attributes(@result).to_json
  end

  protected
  def get_attributes(list)
    list.map do |node|
      attribute = { :data => node.name, :attr => {:id =>  node.id.to_s } }
      # 叶子节点不需要state,children
      attribute.merge!(:state => "open", :children => get_attributes(node.children)) unless node.children.empty?
      attribute
    end
  end
end
