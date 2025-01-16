import Microbes from "~/assets/microbes.pdf";
import { Content } from "~/layouts";
import { Title } from "~/meta";

export default function Writing() {
  return (
    <Content title="Writing">
      <Title>Writing</Title>
      <h2>
        <a href="https://www.getty.edu/about/whatwedo/getty_magazine/gettymag_spring2020.pdf">
          "Cultures on Culture: Biofilm, Conservation, and the Interface of Art and Environment"
        </a>
      </h2>
      <p>
        While a 2019-20 "Art and Ecology" postdoctoral fellow at the Getty Research Institute, I
        wrote a brief description of my project in <span class="italic">The Getty Magazine</span>.
      </p>

      <h2>
        <a href="https://www.tandfonline.com/eprint/a4XxE3yTrtvwDtCUekA8/full">
          "Cigarettes, Saliva, Art: Laboratory Expertise in Florence, Italy"
        </a>
      </h2>
      <p>
        In Florence, I followed artisanal and scientific restoration practices. This article focuses
        on seemingly trivial material traces — the monk's cigarette and the chemist's saliva — as
        embodiments of these experts' confidence and discernment with precious historical and
        aesthetic artifacts. I argue that both the artisan and the scientist perform expertise by
        relying on sensory, craft-based familiarity with materials. Published in the{" "}
        <span class="italic">Journal of Modern Craft</span>.
      </p>

      <h2>
        <a href={Microbes}>
          "Putting Microbes to Work: Using Biotechnology to Restore Architecture & Art in Italy"
        </a>
      </h2>
      <p>
        How are artworks and cultural heritage made into restoration "workspaces" for microbes?
        Here, I think through the implications of the multispecies work that brings microbiologists
        and bacteria together to clean and consolidate artifacts ranging from ancient clay terraces
        in Sicily to a modern stone statue in the Monumental Cemetery of Milan. Published in{" "}
        <span class="italic">Thresholds</span>.
      </p>

      <h2>
        <a href="http://histanthro.org/reviews/all-the-world-is-here/">
          "All the World Is Here," Exhibition Review
        </a>
      </h2>
      <p>
        My colleague, Alison Laurence, and I reviewed the exhibition,{" "}
        <span class="italic">
          All the World Is Here: Harvard's Peabody Museum and the Invention of American Anthropology
        </span>
        , at Harvard University's Peabody Museum of Archaeology & Ethnology. Published in the{" "}
        <span class="italic">History of Anthropology Newsletter</span>.
      </p>
    </Content>
  );
}
