# frozen_string_literal: true

module Polaris
  class ResourceItemComponent < Polaris::NewComponent
    CURSOR_DEFAULT = :default
    CURSOR_OPTIONS = %i[default pointer]

    ALIGNMENT_DEFAULT = :default
    ALIGNMENT_MAPPINGS = {
      ALIGNMENT_DEFAULT => "",
      center: "Polaris-ResourceItem--alignmentCenter",
    }
    ALIGNMENT_OPTIONS = ALIGNMENT_MAPPINGS.keys

    renders_one :media

    def initialize(
      url: nil,
      vertical_alignment: ALIGNMENT_DEFAULT,
      wrapper_arguments: {},
      container_arguments: {},
      **system_arguments
    )
      @url = url
      @vertical_alignment = vertical_alignment
      @wrapper_arguments = wrapper_arguments
      @container_arguments = container_arguments
      @system_arguments = system_arguments
    end

    def wrapper_arguments
      {
        tag: "li",
        data: {},
      }.deep_merge(@wrapper_arguments).tap do |args|
        args[:classes] = class_names(
          args[:classes],
          "Polaris-ResourceItem__ListItem",
        )
        prepend_option(args[:data], :controller, "polaris-resource-item")
      end
    end

    def container_arguments
      {
        tag: "div",
      }.deep_merge(@container_arguments).tap do |args|
        args[:classes] = class_names(
          args[:classes],
          "Polaris-ResourceItem__Container",
          ALIGNMENT_MAPPINGS[fetch_or_fallback(ALIGNMENT_OPTIONS, @vertical_alignment, ALIGNMENT_DEFAULT)],
        )
      end
    end

    def system_arguments
      {
        tag: "div",
        data: {},
      }.deep_merge(@system_arguments).tap do |args|
        args[:classes] = class_names(
          args[:classes],
          "Polaris-ResourceItem",
        )
        prepend_option(args, :style, "cursor: #{cursor};")
        prepend_option(args[:data], :action, "click->polaris-resource-item#open")
      end
    end

    private
      def cursor
        @url.present? ? "pointer" : "default"
      end
  end
end