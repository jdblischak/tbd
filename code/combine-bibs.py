#!/usr/bin/env python

"""
Combine two BibTeX files.

1. Organize alphabetically by ID.
2. Only include the following fields: author, year, title, journal,
   volume, number, pages, doi.
3. For duplicate keys, use the entry in the first listed file.

Usage:
  python combine-bibs.py one.bib two.bib > new.bib
"""

import os
import sys
import bibtexparser as bib

args = sys.argv
assert len(args) == 3, \
    "Usage: python combine-bibs.py one.bib two.bib > new.bib"

# Process first file
file1 = args[1]
assert os.path.isfile(file1), \
    "bibtex file %s does not exist"%(file1)
with open(file1) as bibtex_file:
    bib1 = bib.load(bibtex_file)
entries1 = bib1.entries_dict
keys1 = set(entries1.keys())

# Process second file
file2 = args[2]
assert os.path.isfile(file2), \
    "bibtex file %s does not exist"%(file2)
with open(file2) as bibtex_file:
    bib2 = bib.load(bibtex_file)
entries2 = bib2.entries_dict
keys2 = set(entries2.keys())

keys_all = list(keys1 | keys2)
keys_all.sort()
duplicates = list(keys1 & keys2)
assert len(keys1) + len(keys2) - len(duplicates) == len(keys_all), \
    "I understand how to use sets."

def write_entry(entry, fields = ["author", "year", "title", "journal",
                                 "volume", "number", "pages", "doi"]):
    """
    Format the dictionary entry into a valid BibTeX string.

    entry - dictionary with (at miniumum) fields ENTRYTYPE and ID
    fields - the additional fields (keys) to extract and format
    """
    entrytype = entry["ENTRYTYPE"]
    out = "@%s{%s,\n"%(entrytype, entry["ID"])
    for field in fields:
        if field in entry.keys():
            # For consortia, encase author name in double brackets so
            # that the full name is used instead of parsing it into a
            # first and last name
            if field == "author" and "," not in entry["author"]:
                out = out + "%s = {{%s}},\n"%(field, entry[field])
            else:
                out = out + "%s = {%s},\n"%(field, entry[field])
        else:
            out = out + "%s = {%s},\n"%(field, "")
    out = out.rstrip(",\n") + "\n}\n"
    return out

for k in keys_all:
    if k in duplicates:
        sys.stderr.write("%s is duplicated. Using entry from %s\n\n"%(
            k, file1))
        sys.stdout.write(write_entry(entries1[k]))
    elif k in keys1:
        sys.stdout.write(write_entry(entries1[k]))
    elif k in keys2:
        sys.stdout.write(write_entry(entries2[k]))
    else:
        sys.stderr.write("Unknown key:\t%s\n\n"%(k))
