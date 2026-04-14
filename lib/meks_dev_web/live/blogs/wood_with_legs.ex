defmodule MeksDevWeb.BlogsLive.WoodWithLegs do
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
        <h1 class={h1_classes()}>Wood with Legs</h1>
        <h3 class={h3_classes()}>Meks McClure · December 27, 2023</h3>

        <p class={p_classes()}>
          My friend George and I are in El Chaltén, a small mountain town in Argentine Patagonia, planning to try via ferrata: harnesses, cables, and iron rungs bolted into a cliff face.
        </p>

        <p class={p_classes()}>
          We walk into a small tour office on main street, well the <em>only</em>
          street really. It's a single-room cabin, with walls, floors, and furniture all in the same warm, polished wood. Sunlight pours through the window, catching dust in the air. Two women are inside, helping us get everything set up.
        </p>

        <p class={p_classes()}>
          They explain the route and make sure we understand what we're signing up for. Then one of them pauses.
        </p>

        <p class={p_classes()}>
          "The weather," she says, "especially the wind, is very important."
        </p>

        <p class={p_classes()}>
          So they don't actually book us. Not yet. They take my card information, but explain they'll only
          charge us the morning of, if conditions are good.
        </p>

        <p class={p_classes()}>
          "Knock on wood," the other woman says.
        </p>

        <p class={p_classes()}>
          They both reach out and knock on the wooden wall beside them.
        </p>

        <p class={p_classes()}>
          I do the same, naturally, and knock on the gleaming wooden table in front of me.
        </p>

        <p class={p_classes()}>
          "No, no, no," one of them gasps.
        </p>

        <p class={p_classes()}>
          George and I stare. "What?"
        </p>

        <p class={p_classes()}>
          "You can't knock on wood with legs," she says.
        </p>

        <p class={p_classes()}>
          She points at the table.
        </p>

        <p class={p_classes()}>
          I look at the table.
        </p>

        <p class={p_classes()}>
          I look at the wall they'd knocked on.
        </p>

        <p class={p_classes()}>
          I look back at the table.
        </p>

        <p class={p_classes()}>
          "Wood has spirits," she says. "That's why you knock on wood. But not wood with legs."
        </p>

        <p class={p_classes()}>
          She pauses.
        </p>

        <p class={p_classes()}>
          "If it has legs, the spirits can run away with your luck."
        </p>

        <p class={p_classes()}>
          "So never tables," her friend says. "Or chairs. Or stools."
        </p>

        <p class={p_classes()}>
          George looks down at his chair and grins.
        </p>

        <p class={p_classes()}>
          We thank them, finish up, and head out.
        </p>
        <p class={p_classes()}>
          Going down the steps, I catch myself brushing my hand against the wooden railing and pulling it back.
        </p>

        <hr class="my-6 border-gray-300" />

        <p class={p_classes()}>
          The next morning, we're up early: packed, ready, excited. We step outside our hostel dorm into the
          sharp morning air and set our things on the picnic table.
        </p>

        <p class={p_classes()}>
          My phone rings.
        </p>

        <p class={p_classes()}>
          "Hi..." says a familiar voice from the office. She sounds out of breath. "We're so sorry. We have to
          cancel today."
        </p>

        <p class={p_classes()}>
          There's been a fire at the farm. Horses broke loose in the chaos, and everyone's out dealing with it.
          No one left to guide. No excursions today.
        </p>

        <p class={p_classes()}>
          The call ends.
        </p>

        <p class={p_classes()}>
          George and I look at each other.
        </p>

        <p class={p_classes()}>
          "Well," I say.
        </p>

        <p class={p_classes()}>
          "Yeah," he says.
        </p>

        <p class={p_classes()}>
          We both look at the table.
        </p>

        <p class={p_classes()}>
          Then George laughs, and I join in.
        </p>

        <p class={p_classes()}>
          "Alright," he says, already pulling out his phone. "Let's see if the others are still on their way
          to Cerro Torre lagoon."
        </p>

        <hr class="my-6 border-gray-300" />

        <p class={p_classes()}>
          We catch our friends on the trail, and George, still amused by the whole morning, recounts the story
          of the table. "You knocked on a <em>table</em>?" Izzy says, shaking her head at me.
        </p>

        <p class={p_classes()}>
          At the lagoon, chunks of glacier float in the pale blue water. I step barefoot into the shallows. The
          water is so clear that I can see the goosebumps forming on my submerged calves.
        </p>

        <p class={p_classes()}>
          But the whole time, somewhere in the back of my mind, I keep thinking:
        </p>

        <p class={p_classes()}>
          Maybe you really shouldn't knock on wood with legs.
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
