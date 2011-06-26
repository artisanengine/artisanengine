class PagesController < InheritedResources::Base
  load_and_authorize_resource
  
  create! do |success, failure|
    success.html { redirect_to @page, notice: "Page was successfully created." }
    failure.html { flash[ :alert ] = t( :form_alert ) and render :new }
  end
  
  protected
    # Scope all pages to the current frame by default.
    def begin_of_association_chain
      current_frame
    end
end