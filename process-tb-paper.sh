# Download Markdown version of file
wget -nc https://bitbucket.org/jdblischak/tb-paper/raw/d58bcaf2806440775bfa1bfea8b78fa6ec1319e0/tb-paper.md

# Convert from Markdown to LaTeX
pandoc -f markdown -t latex -o tb-paper.tex tb-paper.md

# Replace μ with valid LaTeX symbol
# https://www.linuxquestions.org/questions/linux-software-2/inserting-microseconds-symbol-in-latex-747611/
sed -i s/μ/$\mu$/g tb-paper.tex

# Fix citations
# Pandoc converted [@ref1; @ref2] to {[}@ref1; @ref2{]}
# Fix the beginning (single quotes required)
# https://www.linuxquestions.org/questions/slackware-14/sed-command-to-replace-slash-with-backslash-136312/#post3166473
sed -i 's/{\[}@/\\cite{/g' tb-paper.tex
# Fix the spacing
sed -i s/"; @"/", "/g tb-paper.tex
# Fix the end
sed -i s/{]//g tb-paper.tex

# Download bibtex file
wget -nc https://bitbucket.org/jdblischak/tb-paper/raw/d58bcaf2806440775bfa1bfea8b78fa6ec1319e0/refs.bib


