class CategoryFieldsController < ApplicationController
  def show
    @item_field = ItemField.find(params[:id])
  end

  # def new
  #   @category = Category.find(params[:category_id])
  #   @item_field = ItemField.new
  # end

  # def edit
  #   @item_field = ItemField.find(params[:id])
  # end

  def create
    @category = Category.find(params[:category_id])
    @item_field = @category.item_fields.build(item_field_params)
    field_group = FieldGroup.new
    field_group.category = @category
    field_group.item_field = @item_field

    if @item_field.save
      field_group.save if params[:category_id]
      flash[:notice] = "ItemField was saved successfully."
    else
      flash.now[:alert] = "Error creating ItemField. Please try again."
    end
    redirect_to @category
  end

  # def update
  #   @item_field = ItemField.find(params[:id])
  #   @item_field.assign_attributes(item_field_params)
  #
  #   if @item_field.save
  #     flash[:notice] = "item_field was updated successfully."
  #     redirect_to action: :index
  #   else
  #     flash.now[:alert] = "Error updated item_field. Please try again."
  #     render :edit
  #   end
  # end

  def destroy
    @category = Category.find(params[:category_id])
    field_group = @category.field_groups.build(category_params)
    #field_group = FieldGroup.find(field_group.id)
    #item_field = ItemField.find(params[:id])
    #field_group = FieldGroup.where(category_id: @category.id, item_field_id: item_field.id)

    if field_group.destroy
      flash[:notice] = "field_group #{field_group.item_field_id} - #{field_group.category_id} was deleted successfully."
      redirect_to @category
    else
      flash.now[:alert] = "There was an error deleting the field_group."
      redirect_to @category
    end
  end

  def category_params
    params.require(:field_group).permit!
  end
end
