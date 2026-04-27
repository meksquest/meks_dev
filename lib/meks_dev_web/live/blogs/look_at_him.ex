defmodule MeksDevWeb.BlogsLive.LookAtHim do
  use MeksDevWeb, :live_view

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture">
      <.primary_button href={~p"/"} class="handwritten text-xl m-8">
        meks.quest
      </.primary_button>

      <.primary_button href={~p"/stories"} class="handwritten text-xl m-3">
        Stories
      </.primary_button>

      <div class={container_classes()}>
        <h1 class={h1_classes()}>Look at Him</h1>
        <h3 class={h3_classes()}>Meks McClure · April 26, 2026</h3>

        <div class={poem_classes()}>
          <p class={p_classes()}>
            <em>Look —</em>
            <br />
            <em>do you see him?</em>
          </p>

          <p class={p_classes()}>
            There, at the edge of the forest.<br /> The one who has just remembered<br />
            he has a body.
          </p>

          <p class={p_classes()}>
            He was held a long time<br /> in a country with no name,<br />
            where the light was the wrong color<br /> and the ground gave nothing back.
          </p>

          <p class={p_classes()}>
            He learned to be small there.<br /> He learned to be silent.
          </p>

          <p class={p_classes()}><em>But look at him now —</em></p>

          <p class={p_classes()}>
            laughing,<br /> loud and doubling over<br /> in the middle of a Tuesday,<br />
            as if the world had just told him<br /> the best joke it knows.
          </p>

          <p class={p_classes()}>
            And then soft at the edge of the day,<br /> the long exhale that means<br />
            <em>yes, this.</em>
          </p>

          <p class={p_classes()}>
            He looks surprised —<br /> as if he had forgotten<br />
            that joy was something he was,<br /> not something he had to earn.
          </p>

          <p class={p_classes()}><em>Look at him. Do you see?</em></p>

          <p class={p_classes()}>
            He is not healed.<br /> He is not finished.<br /> He is not the same as before.
          </p>

          <p class={p_classes()}>
            He is something that has been through fire<br /> and come out knowing its own name.
          </p>

          <p class={p_classes()}><em>Look at him.</em></p>

          <p class={p_classes()}>He is exactly this.</p>

          <p class={p_classes()}><em>And he is beautiful.</em></p>
        </div>
      </div>
    </div>
    """
  end

  defp container_classes, do: "mx-auto max-w-3xl px-6 py-8"

  defp h1_classes, do: "text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 mb-6"
  defp h3_classes, do: "text-xl font-semibold text-gray-900 mt-8 mb-3"

  defp poem_classes, do: "mt-10 space-y-2"

  defp p_classes, do: "text-gray-800 leading-relaxed pb-4"

  defp hr_classes, do: "my-8 border-t border-gray-300"

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
end
