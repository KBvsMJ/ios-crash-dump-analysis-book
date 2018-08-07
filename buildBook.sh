#!/bin/bash

rm foo.*

# We allow first person in the preface and second person in the Introduction.
# Elsewhere it is third person only.

echo Usages of "you" in the narrative
grep --color you $(cat frontPages.txt mainPages.txt | egrep -v 'Introduction|Preface') -c | grep --color -v hammer
echo
grep --color you $(cat frontPages.txt mainPages.txt | egrep -v 'Introduction|Preface') | grep --color -v hammer

pandoc $(cat frontPages.txt mainPages.txt) pandocMetaData.yaml -f markdown+smart --standalone --bibliography bibliography.bib --toc -c style/gitHubStyle.css -o foo.html
pandoc $(cat frontPages_latex.txt mainPages.txt) pandocMetaData.yaml -f markdown+smart --standalone --bibliography bibliography.bib --toc --template=style/simple.latex  -V documentclass=book -o foo.latex
pdflatex foo.latex > foo.pass.0.log
pdflatex foo.latex > foo.pass.1.log
pdflatex foo.latex > foo.pass.2.log

pandoc $(cat frontPages.txt mainPages.txt) pandocMetaData.yaml -f markdown+smart --standalone --bibliography bibliography.bib --toc --css=style/ebook.css -o foo.epub

#pandoc $(cat pageOrder.txt) pandocMetaData.yaml -f markdown+smart --standalone --bibliography bibliography.bib -o foo.docx  ## This gets you a docx file which you can style edit, save and then run the reference-doc command instead to use the style of that document.
pandoc $(cat frontPages.txt mainPages.txt) pandocMetaData.yaml -f markdown+smart --standalone --bibliography bibliography.bib --reference-doc=style/referenceWordDocumentTemplate.docx -o foo.docx
#/Applications/calibre.app/Contents/console.app/Contents/MacOS/ebook-convert foo.docx foo.calibre.epub

mkdir -p docs
cp foo.html docs/index.html
git add docs/index.html
rm -rf docs/screenshots docs/style
cp -pr screenshots docs/screenshots
cp -pr style docs/style
git add docs/screenshots docs/style
git commit -m'update published book on github pages'
git push
