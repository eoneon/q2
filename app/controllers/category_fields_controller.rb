class CategoryFieldsController < ApplicationController
  def show
    @item_field = ItemField.find(params[:id])
  end

  # def new
  #   @category = Category.find(params[:category_id])
  #   @item_field = ItemField.new
  # end

  def edit
    @item_field = ItemField.find(params[:id])
  end

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
    render :new
  end

  def update
    @item_field = ItemField.find(params[:id])
    @item_field.assign_attributes(item_field_params)

    if @item_field.save
      flash[:notice] = "item_field was updated successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "Error updated item_field. Please try again."
      render :edit
    end
  end

  def item_field_params
    params.require(:item_field).permit!
  end
end
