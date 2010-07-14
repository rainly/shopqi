# encoding: utf-8
class ImagesController < InheritedResources::Base
  actions :new, :create, :edit, :update
  respond_to :js, :only => [:create, :update]

  edit! do |format|
    format.js { render :action => "new" }
  end

  create! do |success, failure|
    failure.js { render :action => "create.failure.js.haml"}
  end

  update! do |success, failure|
    failure.js { render :action => "update.failure.js.haml"}
  end
end