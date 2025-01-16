import CV from "~/assets/cv.pdf";
import { Content } from "~/layouts";
import { Title } from "~/meta";

export default function About() {
  return (
    <Content title="About">
      <Title>About</Title>
      <p>
        I am an anthropologist of art and science, with a focus on how authenticity, expertise,
        duration, and materiality come to matter through laboratory practice. My current book
        project examines how scientists develop technologies for the restoration of art and cultural
        heritage. I received my PhD in{" "}
        <a href="https://hasts.mit.edu/">
          History, Anthropology, and Science, Technology, and Society (HASTS) at MIT
        </a>{" "}
        in 2019.
      </p>
      <p>
        In 2019-20, I was a Postdoctoral Fellow in the Scholars Program at the{" "}
        <a href="http://www.getty.edu/research/scholars/years/2019_2020.html">
          Getty Research Institute
        </a>{" "}
        in Los Angeles. In 2020-21, I was an ACLS Emerging Voices Postdoctoral Fellow at Vanderbilt
        University. While at Vanderbilt, I was also co-PI on a Mellon-funded, pedagogical project
        called "
        <a href="https://www.nestedknowledge.online/">
          Nested Knowledge: Disentangling History, Truth, and Race in STEM Experiences
        </a>
        " described in <a href="https://www.youtube.com/watch?v=QH66NbWqMbU">a short video here</a>.
      </p>
      <p>
        Since 2021, I have been a post-doctoral researcher in the Department of History and Art
        History at Utrecht University, where I am working in the ERC-funded project,{" "}
        <a href="https://durare.sites.uu.nl">
          DURARE: Dynamics of the Durable: A History of Making Things Last in the Visual and
          Decorative Arts
        </a>
        .
      </p>
      <p>
        My <a href={CV}>curriculum vitae</a> is also available for download.
      </p>
    </Content>
  );
}
