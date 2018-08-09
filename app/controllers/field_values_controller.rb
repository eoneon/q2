class FieldValuesController < ApplicationController
  def index
    @field_values = FieldValue.all
    respond_to do |format|
      format.html
      format.csv { send_data @field_values.to_csv }
      format.xls { send_data @field_values.to_csv(col_sep: "\t") }
    end
  end

  def show
    @field_value = FieldValue.find(params[:id])
  end

  def new
    @item_field = ItemField.find(params[:item_field_id])
    @field_value = FieldValue.new
  end

  def edit
    @field_value = FieldValue.find(params[:id])
  end

  def create
    @item_field = ItemField.find(params[:item_field_id])
    @field_value = @item_field.field_values.build(field_value_params)

    if @field_value.save
      flash[:notice] = "FieldValue was saved successfully."
    else
      flash.now[:alert] = "Error creating FieldValue. Please try again."
    end
    render :edit
  end

  def update
    @field_value = FieldValue.find(params[:id])
    @field_value.assign_attributes(field_value_params)

    if @field_value.save
      flash[:notice] = "field_value was updated successfully."
      #redirect_to action: :index
    else
      flash.now[:alert] = "Error updated field_value. Please try again."
      #render :edit
    end
    render :edit
  end

  def destroy
    @field_value = FieldValue.find(params[:id])

    if @field_value.destroy
      flash[:notice] = "\"#{@field_value.name}\" was deleted successfully."
      redirect_to category_item_field_path(@field_value.item_field)
    else
      flash.now[:alert] = "There was an error deleting the field_value."
      render :show
    end
  end

  def import
    FieldValue.import(params[:file])
    redirect_to field_values_path, notice: 'Field Values imported.'
  end

  private

  def field_value_params
    params.require(:field_value).permit!
  end
end
