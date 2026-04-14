defmodule MeksDevWeb.BlogsLive.BlueberriesInKrakow do
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
        <h1 class={h1_classes()}>Blueberries</h1>
        <h3 class={h3_classes()}>Meks McClure · May 11, 2025</h3>

        <p class={p_classes()}>
          I'm in a supermarket in Kraków.
        </p>

        <p class={p_classes()}>
          I've made the mistake of showing up already a little hungry, which is never a good way to start a grocery shop. But I had gotten off the plane just hours earlier and needed sustenance.
        </p>

        <p class={p_classes()}>
          I don't speak Polish, so I'm wandering the aisles with my phone in hand, pointing it at labels so my translate app can help me decipher what I'm even looking at. Half the translations don't make a lick of sense. I'm standing in the dairy aisle staring at my screen: <em>"paralysis cheese"</em>.
          <em>What kind of cheese?</em>
        </p>

        <p class={p_classes()}>
          I finally make it to the fruit section and think,
          <em>
            Ok, this is safe. Blueberries. I can handle blueberries. I don't need Translate for blueberries.
          </em>
        </p>

        <p class={p_classes()}>
          So I pick up a container. <em>This looks fine.</em>
          I start lowering it into my shopping basket…
        </p>

        <p class={p_classes()}>
          …and it disappears from my hands.
        </p>

        <p class={p_classes()}>
          <em>What?!</em>
        </p>

        <p class={p_classes()}>
          I look up. A tiny woman, gray hair pulled back in a severe bun, barely reaching my shoulders, is staring up at me. The blueberries are now in her hands.
        </p>

        <p class={p_classes()}>
          "No, no, no," she says thickly.
        </p>

        <p class={p_classes()}>
          Now I'm completely flustered. Did <em>she</em>
          want those blueberries? Had I committed some kind of cultural crime?
        </p>

        <p class={p_classes()}>
          She turns, fully committing, and puts the blueberries back.
        </p>

        <p class={p_classes()}>
          Then she starts inspecting the others. One by one. Lifting them, judging them, rejecting them like they've personally offended her.
        </p>

        <p class={p_classes()}>
          Finally, she finds one.
        </p>

        <p class={p_classes()}>
          She places it in my hands, taps it, and with a cheeky grin that makes her whole face light up, she says, "Yes, yes."
        </p>

        <p class={p_classes()}>
          I look down at the blueberries. Honestly, they do look better. I put my phone in my pocket.
        </p>

        <p class={p_classes()}>
          When I look back up, she's gone.
        </p>

        <p class={p_classes()}>
          Even here, oceans away from home, apparently, I still need help picking blueberries.
        </p>
      </div>
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
end
