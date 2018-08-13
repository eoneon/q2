require 'active_support/concern'

module FlatArt
  extend ActiveSupport::Concern

  def substrate_type
    %w(canvas paper board) & field_values.pluck(:name)
  end

  def mounting_type
    %w(framed wrapped border) & field_values.pluck(:name)
  end

  def edition_type
    %w(numbered_qty numbered_xy from_an_edition roman_numbered) & field_values.pluck(:name)
  end

  def original_base
    %w(mounting_type original_kind substrate_type signature_kind certificate_kind)
  end

  def self.original_painting
    %w(mounting_type original_kind paint_medium substrate_type canvas_kind paper_kind board_kind signature_kind certificate_kind)
  end
end
