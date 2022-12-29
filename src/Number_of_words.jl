#- Import the required packages
using DataFrames
using Plots

#- Read the text file
open("../utils/p.txt", "r") do io
  global text = read(io, String)
end;

#- Define the function that does the job
function do_the_job(string::String)
  b = replace(string, r"([.?!])\s*(?=[A-Z])" => s"\1|")
  b = replace(b, r"\r\n" => " ")
  b = replace(b, r"[.]"=>"")
  b = split(b, "|")

  un_words = unique(lowercase.(collect(Base.Flatten(split.(b, " ")))))

  dict = Dict{String, Vector{Int64}}()
  for word in un_words
      dict[word] = count.(==(1), broadcast.(==("$word"), split.(b, " ")))
  end
  final = hcat(DataFrame(words = un_words), permutedims(DataFrame(dict)))
  rename!(final, Dict("x$i"=>"sentence $i" for i=1:size(final, 2)-1))
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
