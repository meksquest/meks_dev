defmodule MeksDevWeb.StoriesLive.Index do
  use MeksDevWeb, :live_view

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture h-screen">
      <.primary_button href={~p"/"} class="handwritten text-xl m-8">
        meks.quest
      </.primary_button>

      <ul class="m-8">
        <li>
          <.styled_link href={~p"/blogs/escape"} class="text-sm">
            Escape - April 07, 2026
          </.styled_link>
        </li>
        <li>
          <.styled_link href={~p"/blogs/sky-water"} class="text-sm">
            Sky Water - November 22, 2025
          </.styled_link>
        </li>
        <li>
          <.styled_link href={~p"/blogs/blueberries-in-krakow"} class="text-sm">
            Blueberries - May 11, 2025
          </.styled_link>
        </li>
        <li>
          <.styled_link href={~p"/blogs/wood-with-legs"} class="text-sm">
            Wood with Legs - December 27, 2023
          </.styled_link>
        </li>
      </ul>
    </div>
    """
  end

  defp container_classes, do: "mx-auto max-w-3xl px-6 py-8"

  defp h1_classes, do: "text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 mb-6"
  defp h3_classes, do: "text-xl font-semibold text-gray-900 mt-8 mb-3"

  defp p_classes, do: "text-gray-800 leading-relaxed mb-4"

  attr :href, :string, required: true
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp primary_button(assigns) do
    ~H"""
    <a
      href={@href}
      class={"inline-flex items-center gap-2 px-6 py-3 bg-journal-charcoal text-journal-cream rounded-lg hover:bg-journal-gray transition-colors duration-200 font-medium shadow-sm hover:shadow-md " <> @class}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end

  attr :href, :string, required: true
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp styled_link(assigns) do
    ~H"""
    <a
      href={@href}
      class={[
        "text-gray-800 hover:text-gray-500 transition-all duration-200 inline-block",
        "md:hover:scale-105",
        "font-medium",
        "underline px-2 py-1",
        @class
      ]}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end
end
