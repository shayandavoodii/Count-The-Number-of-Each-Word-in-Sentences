# <p align="center">Count The Number of Each Word in Sentences</a>
<p align="justify">
I defined a function that calculates the occurrence of each word in each sentence of the text for $word\in(text)$. The text can be loaded from a .txt file or can be passed as a string to function. Lastly, I wrote the required <code>plot</code> function with arbitrary arguments to plot the length of each sentence for $sentence\in(text)$ based on the count of the words in each one.  
For example, given the <a href="https://github.com/shayandavoodii/Count-The-Number-of-Each-Word-in-Sentences/blob/main/utils/p.txt"><code>p.txt</code></a> file, I can first read and bind it to a variable, named <code>text</code>:
</p>

```julia
open("../utils/p.txt", "r") do io
  global text = read(io, String)
end;
```

<p align="justify">Afterward, it's ready to be passed to the <code>do_the_job</code> function to get the number of occurrences of each word in each sentence of the <code>text</code>:</a>

```julia
final = do_the_job(text)
# 19×6 DataFrame
#  Row │ words    sentence 1  sentence 2  sentence 3  sentence 4  sentence 5
#      │ String   Int64       Int64       Int64       Int64       Int64
# ─────┼─────────────────────────────────────────────────────────────────────
#    1 │ a                 0           0           1           1           0
#    2 │ and               0           0           0           1           0
#    3 │ animals           0           0           0           1           0
#    4 │ are               0           0           0           0           0
#    5 │ be                0           0           1           0           0
#    6 │ brown             0           0           0           2           2
#    7 │ dog               1           1           1           0           0
#    8 │ fox               0           0           0           0           1
#    9 │ jumped            0           0           0           1           0
#   10 │ jumping           1           1           0           0           1
#   11 │ lazy              1           1           1           0           0
#   12 │ other             1           1           0           0           0
#   13 │ over              1           0           0           0           0
#   14 │ quick             0           0           0           0           1
#   15 │ saw               1           1           0           0           0
#   16 │ seem              1           1           0           0           0
#   17 │ the               0           0           1           0           0
#   18 │ there             0           0           0           1           0
#   19 │ to                1           0           0           0           1
```

And, I can plot it using the following code to see the length of each sentence:

```julia
using Plots

bar(
  sum(Matrix(final[!, 2:end]), dims=1)',
  title="Count of words in each sentence",
  titlefontsize=30,
  xlabel="Sentence",
  ylabel="Count",
  label="Count",
  xticks=(1:size(final, 2)-1, names(final[!, 2:end])),
  size=(2000, 1000),
  xrotation=45,
  xtickfontsize=20,
  ytickfontsize=20,
  bottom_margin=40Plots.mm,
  left_margin=15Plots.mm,
  xlabelfontsize=20,
  ylabelfontsize=20,
  legendfontsize=20,
  dpi=300
)
```

![plot](https://user-images.githubusercontent.com/52105833/209954977-4266e5be-bedf-4dfb-a5e5-8c84ed1d5a61.png)
Similarly, I can pass a string to `do_the_job`:

```julia
text = """Animals are multicellular, eukaryotic organisms of the kingdom Animalia
(also called Metazoa). The animal kingdom emerged as a basal clade within Apoikozoa as a sister of the choanoflagellates. Animals are motile, meaning they can move spontaneously and independently at some point in their lives. Their body plan eventually becomes fixed as they develop, although some undergo a process of
metamorphosis later in their lives. All animals are heterotrophs: they must ingest other organisms or their products for sustenance. Most known animal phyla appeared in the fossil record as marine species during the Cambrian explosion, about 542 million years ago. Animals can be divided broadly into vertebrates and invertebrates. Vertebrates have a backbone or spine, and amount to less than five
percent of all described animal species. They include fish, amphibians, reptiles, birds and mammals. The remaining animals are the invertebrates, which lack a backbone. These include molluscs (such as octopuses and squid), arthropods (such as insects and crustaceans), annelids (such as worms), nematodes (such as roundworms), flatworms (such as tapeworms), cnidarians (such as sea anemones and jellyfish),
ctenophores (such as comb jellies), and placozoans (such as placozoans). The study of animals is called zoology. The word "animal" comes from the Latin animalis, meaning having breath, having soul or living being. The biological definition of the word refers to all members of the kingdom Animalia, encompassing creatures as
diverse as sponges, jellyfish, insects, and humans. Aristotle divided the world of living things between animals and plants, and this was followed by Carl Linnaeus, who established the kingdoms of animals, plants, and minerals. In the 19th century, when the modern evolutionary synthesis was established, the kingdoms were shown to
be artificial, and most biologists instead use an all-encompassing phrase such as the "animal kingdom" or just "animals". However, it is still commonly used in zoology, and more specifically in taxonomy, where it is preferred to avoid the ambiguity of the word "animal" in the context of taxonomic nomenclature."""

final = do_the_job(text)
# 190×20 DataFrame
#  Row │ words             sentence 1  sentence 2  sentence 3  sentence 4  sentence 5  sentence 6  sentence  ⋯
#      │ String            Int64       Int64       Int64       Int64       Int64       Int64       Int64
# ─────┼──────────────────────────────────────────────────────────────────────────────────────────────────────
#    1 │                            0           0           0           0           0           0            ⋯
#    2 │ a                          0           0           0           0           0           0
#    3 │ about                      0           0           0           1           0           0
#    4 │ ago                        0           0           0           0           0           0
#    5 │ all                        0           1           0           0           0           0            ⋯
#    6 │ all-encompassing           0           0           1           1           1           0
#    7 │ also                       0           0           0           0           0           0
#    8 │ although                   1           0           0           0           0           0
#    9 │ ambiguity                  0           1           0           0           0           0            ⋯
#   10 │ amount                     0           0           0           0           0           0
#   11 │ amphibians                 0           0           0           0           0           0
#   12 │ an                         0           0           0           0           0           0
#   13 │ and                        0           0           0           0           0           0            ⋯
#   14 │ anemones                   0           0           0           0           0           1
#   15 │ animal                     0           0           1           0           0           0
#   16 │ animalia                   0           0           0           0           0           0
#   17 │ animalis                   1           1           0           1           0           0            ⋯
#   18 │ animals                    0           0           0           0           0           1
#   19 │ annelids                   0           0           1           1           0           0
#   20 │ apoikozoa                  0           0           0           0           0           0
#   21 │ appeared                   0           0           0           1           0           0            ⋯
#   22 │ are                        0           2           0           1           0           0
#   23 │ aristotle                  0           0           0           0           0           0
#   ⋮  │        ⋮              ⋮           ⋮           ⋮           ⋮           ⋮           ⋮           ⋮     ⋱
#  169 │ these                      1           1           0           0           0           0
#  170 │ they                       0           0           0           0           0           0            ⋯
#  171 │ things                     0           0           0           0           0           0
#  172 │ this                       0           0           0           0           0           0
#  173 │ to                         0           0           0           0           0           0
#  174 │ undergo                    0           0           0           0           0           0            ⋯
#  175 │ use                        0           0           1           1           1           0
#  176 │ used                       0           0           0           0           0           0
#  177 │ vertebrates                0           0           0           0           0           1
#  178 │ was                        0           1           0           0           0           0            ⋯
#  179 │ were                       0           0           0           0           0           0
#  180 │ when                       0           0           0           0           0           0
#  181 │ where                      0           0           0           0           0           0
#  182 │ which                      0           0           0           0           0           0            ⋯
#  183 │ who                        0           0           0           0           0           0
#  184 │ within                     0           0           0           0           0           0
#  185 │ word                       0           0           0           0           1           0
#  186 │ world                      0           0           0           0           0           0            ⋯
#  187 │ worms                      0           0           0           0           0           0
#  188 │ wow                        0           0           0           0           0           0
#  189 │ years                      0           0           0           0           0           0
#  190 │ zoology                    1           0           0           0           0           0            ⋯                                                                             13 columns and 145 rows omitted
```
