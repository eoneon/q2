class FieldGroupsController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @field_group = @category.field_groups.build(field_group_params)

    if @field_group.save
      flash[:notice] = "Field group was saved successfully."
      redirect_to @category
    else
      flash.now[:alert] = "Error creating Field group. Please try again."
      redirect_to @category
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @field_group = @category.field_groups.build(sub_field_id: params[:id])

    if @field_group.destroy
      flash[:notice] = "Field group was deleted successfully."
      redirect_to @category
    else
      flash.now[:alert] = "There was an error deleting the Field group."
      redirect_to @category
    end
  end

  private

  def field_group_params
    params.require(:field_group).permit!
  end
end
