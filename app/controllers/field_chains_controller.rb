class FieldChainsController < ApplicationController
  def create
    @item_field = ItemField.find(params[:item_field_id])
    @field_chain = @item_field.field_chains.build(field_chain_params)

    if @field_chain.save
      flash[:notice] = "Field chain was saved successfully."
      redirect_to @item_field
    else
      flash.now[:alert] = "Error creating Field chain. Please try again."
      redirect_to @item_field
    end
  end

  def destroy
    @item_field = ItemField.find(params[:id])
    @field_chain = @item_field.field_chains.build(sub_field_id: params[:id])

    if @field_chain.destroy
      flash[:notice] = "Field chain was deleted successfully."
      redirect_to @item_field
    else
      flash.now[:alert] = "There was an error deleting the Field chain."
      redirect_to @item_field
    end
  end

  private

  def field_chain_params
    params.require(:field_chain).permit!
  end
end
