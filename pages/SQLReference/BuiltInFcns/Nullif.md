---
title: NULLIF built-in SQL function
summary: Built-in SQL function that returns the first argument, or returns NULL if both arguments are equal
keywords: null if,
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_nullif.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# NULLIF

The `NULLIF` function compares the values of two expressions; if they
are equal, it returns `NULL`; otherwise, it returns the value of the
first expression.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    NULLIF (expression1, expression2 )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
expression1
{: .paramName}

The first .expression whose value you want to compare.
{: .paramDefnFirst}

You cannot specify the literal `NULL` for <span
class="CodeItalicFont">expression1</span>.
{: .noteNote}

expression2
{: .paramName}

The first .expression whose value you want to compare.
{: .paramDefnFirst}

</div>
## Results

The `NULLIF` function is logically similar to the following &nbsp; 
[`CASE`](sqlref_expressions_case.html) expression:

<div class="preWrapper" markdown="1">
    CASE WHEN expression1 = expression2 THEN NULL ELSE expression1 END;
{: .Example xml:space="preserve"}

</div>
## Example

<div class="preWrapper" markdown="1">

    splice> Select DisplayName "Position Player", NULLIF(Position,'P') "Position"
       FROM Players
       WHERE MOD(ID, 2)=1
       ORDER BY Position;
    Position Player         |Pos&
    -----------------------------
    Barry Morse             |1B
    David Janssen           |1B
    John Purser             |2B
    Kelly Tamlin            |2B
    Kelly Wacherman         |2B
    Mitch Duffer            |3B
    Mitch Canepa            |3B
    Buddy Painter           |C
    Andy Sussman            |C
    Yuri Milleton           |C
    Edward Erdman           |C
    Alex Paramour           |CF
    Pablo Bonjourno         |CF
    Jeremy Johnson          |CF
    Tad Philomen            |CF
    Nathan Nickels          |IF
    George Goomba           |IF
    Don Allison             |IF
    Trevor Imhof            |LF
    Elliot Andrews          |MI
    Greg Brown              |OF
    Jeremy Packman          |OF
    Jason Pratter           |OF
    Reed Lister             |OF
    Roger Green             |OF
    Charles Heillman        |NULL
    Thomas Hillman          |NULL
    Tam Lassiter            |NULL
    Mitch Lovell            |NULL
    Justin Oscar            |NULL
    Gary Kosovo             |NULL
    Steve Raster            |NULL
    Jason Lilliput          |NULL
    Cory Hammersmith        |NULL
    Barry Bochner           |NULL
    Carl Marin              |NULL
    Larry Lintos            |NULL
    Tim Lentleson           |NULL
    Carl Vanamos            |NULL
    Steve Mossely           |NULL
    Manny Stolanaro         |NULL
    Michael Hillson         |NULL
    Neil Gaston             |NULL
    Mo Grandosi             |NULL
    Mark Hasty              |NULL
    Stephen Tuvesco         |NULL
    Joseph Arkman           |UT

    47 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CASE`](sqlref_expressions_case.html) expression

</div>
</section>
