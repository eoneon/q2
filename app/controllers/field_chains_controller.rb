class FieldChainsController < ApplicationController
  def create
    #params[:id] comes through via prev request, i.e.e, object from form_tag
    #params[:sub_field_id] passed into url inside link
    @field_chain = FieldChain.new(item_field_id: params[:item_field_id], sub_field_id: params[:sub_field_id])
    @item_field = ItemField.find(params[:item_field_id])
    #@field_chain = @item_field.field_chains.build(sub_field_id: params[:sub_field_id])

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
end
