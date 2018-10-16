# splicedocs-jekyll
This is the REPO for Splice Machine customer documentation.

## Branches
There are currently three main branches of the documentation:
* The MASTER branch, which is used to build the latest staged version (2.8 as of Oct 2018)
* The DocsTest2.7 branch, which reflects the 2.7 customer documentation
* The DocsTest2.5 branch, which reflects the 2.5 customer documentation

The latest customer docs (DocsTest2.7) branch and Master branch are typically in sync; however, the DocsTest2.5 uses a different navigational structure, with some different permalinks. This means that DocsTest2.5 must be updated independently: you __cannot__ push the same changes to 2.5 as you push to master/2.7 branches.

## Editing Caveats
There are a few cautions to be aware of when editing doc topics:
* The YAML front matter at the top of each page must not be modified.
* You'll notice the use of kramdown formatting extensions in the topics; these are enclosed in "{: }" sections and apply to the previous block. Please do not modify these or use your own; the docs have standard formatting that makes extensive use of these extensions.
* You'll also notice HTML interspersed with the markdown in topics. This is a) historical: all of our content used to be managed by an HTML editor, and b) allows formatting options that are not possible in markdown, specifically in code blocks and table definitions. 
  An __important__ note: you can use HTML within markdown, but you __cannot__ use markdown within HTML. If you're editing an HTML block in a topic page, you must use HTML for all formatting.
  
## Questions and Concerns
Contact ghillerson@splicemachine.com.
