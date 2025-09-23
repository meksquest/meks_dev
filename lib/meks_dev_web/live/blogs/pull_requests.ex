defmodule MeksDevWeb.BlogsLive.PullRequest do
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

      <div class={container_classes()}>
        <h1 class={h1_classes()}>The Theatre of Pull Requests and Code Review</h1>
        <h3 class={h3_classes()}>Meks McClure · September 23, 2025</h3>

        <img
          src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/z87j4h0uin8v9zgs26wo.png"
          alt="Goatmire"
          class={img_classes()}
        />
        <a
          href="https://www.linkedin.com/in/petter-bostr%C3%B6m-a72ba788/"
          class={"#{a_classes()} #{credit_link_classes()}"}
        >
          Photo Credit to Petter Boström
        </a>

        <div class="h-4" />

        <p class={p_classes()}>
          I recently attended the
          <a href="https://goatmire.com/" class={a_classes()}>Goatmire Elixir Conf</a>
          and one of the standout talks for me was
          <a href="https://www.linkedin.com/in/sasajuric/" class={a_classes()}>Saša Jurić's</a>
          "Tell Me a Story". It was an incredible presentation that combined theatrical storytelling with practical technical advice. Saša performed parts of his talk in character, turning technical topics into a compelling narrative that was part comedy, part tragedy, and fully packed with useful insights I've started implementing myself. The recording will eventually be released online for viewing. I highly recommend that people watch it, and I'll endeavor to add a link to it here when it becomes available.
        </p>

        <img
          src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/8xfruldbkakxrl1d1ib6.png"
          alt="Sasa Juric"
          class={img_classes()}
        />
        <a
          href="https://www.linkedin.com/in/petter-bostr%C3%B6m-a72ba788/"
          class={"#{a_classes()} #{credit_link_classes()}"}
        >
          Photo Credit to Petter Boström
        </a>

        <h2 class={h2_classes()}>The Code Review Challenge</h2>

        <p class={p_classes()}>
          The talk focused on Code Review and Pull Requests (PRs). Saša laid out common problems most software engineers face. Too often, engineers dread code reviews even though they're a significant part of team collaboration. We avoid them because PRs tend to be too large, too complex, too difficult to comprehend, and too painful to test. So we end up commenting "Looks Good To Me" and suggesting a few minor styling improvements to give the appearance of a thorough review.
        </p>

        <p class={p_classes()}>
          This is how security leaks happen and codebases become progressively unmaintainable. Since git blame only points to the original author, it's easy to think "if something goes wrong, it's not on me". But we're all responsible for the whole system, regardless of who wrote the individual lines of code.
        </p>

        <h2 class={h2_classes()}>What Makes a PR Reviewable?</h2>

        <p class={p_classes()}>
          So how do we review something that feels unreviewable? Saša advocates for normalizing the practice of returning difficult-to-understand PRs to the author. This makes logical sense, but it's challenging to implement because it can feel like admitting we're not smart enough to understand the code. However, saying "I don't understand this enough to approve it" is far more valuable than pretending with an empty "LGTM".
        </p>

        <p class={p_classes()}>
          If we commit to only reviewing truly reviewable PRs, what does that look like? According to Saša, it should take the average reviewer 5-10 minutes. By 'average reviewer,' he means mid-to-senior developers who understand the domain, business, and tech stack well—not newcomers still learning the system or mythical 10x engineers.
        </p>

        <p class={p_classes()}>
          How do you create a PR that can be reviewed in 5-10 minutes? By reducing the scope. A full feature should often be multiple PRs. A good rule of thumb is 300 lines of code changes - once you get above 500 lines, you're entering unreviewable territory.
        </p>

        <h2 class={h2_classes()}>Telling a Story with Commits</h2>

        <p class={p_classes()}>
          A key part of having a reviewable PR is writing commits that tell a story. Present your changes incrementally and logically so reviewers can follow your thought process. Generic commit messages such as "add dependency," "implement file upload feature," and "address PR feedback" don’t tell much of a story and leave reviewers guessing. Why was the dependency added? What were the specific steps in creating the file uploader feature? What feedback is being addressed?
        </p>

        <h3 class={h3_classes()}>Story-Telling Commit Messages</h3>

        <p class={p_classes()}>
          After a toast to the demo gods, Saša demonstrated writing story-telling commits with a live coding example, creating a PR that was part of a larger feature. His
          <a href="https://github.com/sasa1977/hamlet/pull/3" class={a_classes()}>example PR</a>
          adds just 152 lines of code, removes 2 lines, but uses 13 thoughtful commits.
        </p>

        <img
          src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/93ugurtvcfo9dp4njj8c.png"
          alt="image of commit messages"
          class={img_classes()}
        />

        <p class={p_classes()}>
          While some developers might understand those 152 lines from the final diff alone, I couldn't confidently approve it without the commit story.
        </p>

        <h3 class={h3_classes()}>Breaking Down the Example</h3>

        <p class={p_classes()}>
          For instance, looking at the overall diff, I didn't understand why he added
          <code class={code_inline_classes()}>:runtime_tools</code>
          to <code class={code_inline_classes()}>applications</code>
          in <code class={code_inline_classes()}>mix.exs</code>. Following the <a
            href="https://github.com/sasa1977/hamlet/pull/3/commits/b94b851a4e8af5cd0905a70d6edc18a72d492df0"
            class={a_classes()}
          >commit narrative</a>, it's clear this was needed for access to
          <code class={code_inline_classes()}>:scheduler.get_sample()</code>
          to collect the samples. Now I can research that context or ask more pointed questions.
        </p>

        <h3 class={h3_classes()}>The Iterative Process</h3>

        <p class={p_classes()}>
          A huge benefit of seeing this live was witnessing the iterative process. In the <a
            href="https://github.com/sasa1977/hamlet/pull/3/commits/299d745cb8bbaf6731098b74f3643b9472ede4b8"
            class={a_classes()}
          >compute average utilization commit</a>, we initially saw an incorrect implementation that computed averages of all schedulers, including offline ones. When testing revealed unexpected results, Saša went back and updated both the code and the commit that originally implemented that function so the story remained coherent.
        </p>

        <p class={p_classes()}>
          A flow that I find to work well for keeping commit history clean is with fixup commits. A fixup is a small commit that’s explicitly marked to be folded into an earlier commit during an interactive rebase. When you run rebase with autosquash, Git automatically pairs each fixup with its target and tucks the changes into the right place, keeping the story coherent without manual reordering.
        </p>

        <p class={p_classes()}>
          I sometimes experience creating merge conflicts for myself during this process. Both Saša and I agree that if it becomes too much effort to resolve the conflict, then creating a new commit is ok. Taking the time to put in extra effort to keep the commit history clean and the story coherent makes the PR easier for reviewers to understand.
        </p>

        <h3 class={h3_classes()}>The Value of Clean History</h3>

        <p class={p_classes()}>
          Keeping the commit history clean connects to advice I've heard about ensuring every commit compiles and keeps the application runnable. I used to follow this loosely, but recent experiences with git bisect emphasized to me its importance. (If you are unfamiliar with
          <a href="https://git-scm.com/docs/git-bisect" class={a_classes()}>git bisect</a>
          , it's worth checking out; it uses a binary search algorithm to find which commit in your project's history introduced a bug.)
        </p>

        <p class={p_classes()}>
          There are a few factors that make narrowing down when and how a regression was introduced more challenging. If a commit doesn't compile, I can't isolate whether the bug first appeared there. If the bug appeared in a commit that had hundreds of lines of code changed, determining which part of the commit is the issue requires significantly more reasoning. A clean commit history with messages that tell a story makes these kinds of investigations easier.
        </p>

        <h2 class={h2_classes()}>Making Review a Collaborative Success</h2>

        <p class={p_classes()}>
          When we present focused PRs with commits that tell clear stories, we get feedback sooner and our development cycles speed up. When reviewers understand our changes, we're more likely to receive valuable feedback instead of blanket approvals, and we're more likely to ship quality code. When our commits make sense, we can travel back in time as needed to understand how our codebase evolved.
        </p>

        <p class={p_classes()}>
          Thanks to Saša's theatrical lesson, I will be more intentional about crafting commit stories. The next time you're preparing a PR, consider:
          <strong class={strong_classes()}>Are you telling a story your reviewers can follow?</strong>
          Start small - maybe focus on just one aspect, like keeping PRs under that 300-line guideline or writing more descriptive commit messages. Your future reviewers (and your future debugging self) will thank you.
        </p>

        <h3 class={h3_classes()}>Resources</h3>

        <ul class={ul_classes()}>
          <li class={li_classes()}>
            <a href="https://git-scm.com/docs/git-blame" class={a_classes()}>Git blame</a>
            for showing which revision and author last modified each line of a file
          </li>
          <li class={li_classes()}>
            <a href="https://git-scm.com/docs/git-rebase" class={a_classes()}>Git rebase</a>
            for cleaning up commit history
          </li>
          <li class={li_classes()}>
            <a
              href="https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---fixupltcommitgt"
              class={a_classes()}
            >
              Git fixup
            </a>
            for amending earlier commits
          </li>
          <li class={li_classes()}>
            <a href="https://git-scm.com/docs/git-bisect" class={a_classes()}>Git bisect</a>
            for finding when bugs were introduced
          </li>
        </ul>
      </div>
    </div>
    """
  end

  # Primary Button Component
  attr :href, :string, required: true
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp primary_button(assigns) do
    ~H"""
    <a
      href={@href}
      class={[
        "inline-flex items-center gap-2 px-6 py-3 bg-journal-charcoal text-journal-cream rounded-lg",
        "hover:bg-journal-gray transition-colors duration-200",
        "font-medium shadow-sm hover:shadow-md",
        @class
      ]}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end

  defp container_classes, do: "mx-auto max-w-3xl px-6 py-8"

  defp h1_classes, do: "text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 mb-6"
  defp h2_classes, do: "text-2xl sm:text-3xl font-semibold text-gray-900 mt-10 mb-4"
  defp h3_classes, do: "text-xl font-semibold text-gray-900 mt-8 mb-3"

  defp p_classes, do: "text-gray-800 leading-relaxed mb-4"
  defp a_classes, do: "text-blue-600 hover:text-blue-700 underline underline-offset-2"
  defp code_inline_classes, do: "font-mono text-sm bg-gray-100 text-gray-900 rounded px-1 py-0.5"
  defp strong_classes, do: "font-semibold"

  defp credit_link_classes,
    do: "block w-full max-w-md mx-auto mt-2 text-left text-sm text-gray-500"

  defp img_classes, do: "mx-auto my-6 w-full rounded-lg shadow"
  defp ul_classes, do: "list-disc pl-6 text-gray-800 space-y-2 mb-4"
  defp li_classes, do: "leading-relaxed"
end
