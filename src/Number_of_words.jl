#- Import the required packages
using DataFrames
using Plots

#- Read the text file
open(joinpath(dirname(@__DIR__), "utils", "p.txt"), "r") do io
  global text = read(io, String)
end;

#- Define the function that does the job
function do_the_job(string::String)
  pattern = r"""(\s?[A-Za-z]+[-']?[A-Za-z]+\s?)|([A-Za-z])|([\.])"""
  text = replace(string, "\n"=>" ", "\""=>"", "..."=>".", "\r"=>"", r"\.[^\s]?"=>". ")
  # show(stdout, "text/plain", text)
  before_split = join(getindex.(text, findall(pattern, text)))
  before_split = replace(before_split, r"\.\s+"=>". ", r"\."=>"")
  a = split(before_split, r"\.\s+")
  un_words = unique(lowercase.(collect(Base.Flatten(split.(a, " ")))))

  dict = Dict{String, Vector{Int64}}()
  for word in un_words
      dict[word] = count.(==(1), broadcast.(==("$word"), split.(a, " ")))
  end
  final = hcat(DataFrame(words = un_words), permutedims(DataFrame(dict)))
  rename!(final, Dict("x$i"=>"sentence $i" for i=1:size(final, 2)-1))
  sort!(final, :words, rev=false)
  return final
end

#- Call the function
final = do_the_job(text)

#- Plot frequency of words in each sentence
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
