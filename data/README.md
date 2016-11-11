# Data

This subdirectory contains the Tables provided as supplemental files.

## Chapter 2

Chapter 2 has 10 tables total. Tables 2-10 are supplemental. They are
available to download from my Bitbucket repo [tb-data][], where they
are labeled from 1-9. I cloned the repo, copied the files, and then
manually renamed them.

[tb-data]: https://bitbucket.org/jdblischak/tb-data

## Chapter 3

Chapter 3 has 5 tables total, and they are all supplemental. They are
available to download from my GitHub repo [tb-suscept][]. I cloned the
repo, copied the files, and then manually renamed them.

[tb-suscept]: https://github.com/jdblischak/tb-suscept

## Chapter 4

Chapter 4 has 4 tables total. They are all supplemental; however, the
first is an image that is embedded directly into the document. Thus
only 2-4 will be provided as separate files. They are available to
download from my GitHub repo [singleCellSeq][]. I cloned the repo,
copied the files, and then manually renamed them.

[singleCellSeq]: https://github.com/jdblischak/singleCellSeq

## Combining into zip file

I have to upload the files manually to the online submission system,
so I zipped them all into one file.

```
cd data
mkdir dissertation-blischak-tables
cp table-* dissertation-blischak-tables
zip -r dissertation-blischak-tables.zip dissertation-blischak-tables
rm -r dissertation-blischak-tables
```
