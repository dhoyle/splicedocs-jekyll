---
title: MOD function
summary: Built-in SQL function that returns the modulus of one value divided by another
keywords: modulus, remainder
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_mod.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# MOD

`MOD` returns the remainder (modulus) of argument 1 divided by argument
2.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    mod(number, divisor)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
number
{: .paramName}

The number for which you want to find the remainder after the division
is performed.
{: .paramDefnFirst}

divisor
{: .paramName}

The number by which you want to divide.
{: .paramDefnFirst}

</div>
## Results

The result is negative only if *number* is negative.

The result of the function is:

* `NULL` if any argument is `NULL`.
* [`SMALLINT`](sqlref_builtinfcns_smallint.html).

The result can be `NULL`; if any argument is `NULL`, the result is the
`NULL`value.

## Examples

<div class="preWrapper" markdown="1">
    splice> VALUES MOD(37, 3);
    1
    ----------
    1

    1 row selected

          ---select players with odd-numbered IDs:
    splice> SELECT ID, Team, DisplayName
       FROM Players
       WHERE MOD(ID, 2) = 1
       ORDER BY ID;
    ID    |TEAM        |DISPLAYNAME
    ----------------------------------------------
    1     |Giants      |Buddy Painter
    3     |Giants      |John Purser
    5     |Giants      |Mitch Duffer
    7     |Giants      |Alex Paramour
    9     |Giants      |Greg Brown
    11    |Giants      |Kelly Tamlin
    13    |Giants      |Andy Sussman
    15    |Giants      |Elliot Andrews
    17    |Giants      |Joseph Arkman
    19    |Giants      |Jeremy Packman
    21    |Giants      |Jason Pratter
    23    |Giants      |Nathan Nickels
    25    |Giants      |Reed Lister
    27    |Giants      |Trevor Imhof
    29    |Giants      |Charles Heillman
    31    |Giants      |Thomas Hillman
    33    |Giants      |Tam Lassiter
    35    |Giants      |Mitch Lovell
    37    |Giants      |Justin Oscar
    39    |Giants      |Gary Kosovo
    41    |Giants      |Steve Raster
    43    |Giants      |Jason Lilliput
    45    |Giants      |Cory Hammersmith
    47    |Giants      |Barry Bochner
    49    |Cards       |Yuri Milleton
    51    |Cards       |Kelly Wacherman
    53    |Cards       |Mitch Canepa
    55    |Cards       |Pablo Bonjourno
    57    |Cards       |Roger Green
    59    |Cards       |Jeremy Johnson
    61    |Cards       |Tad Philomen
    63    |Cards       |Barry Morse
    65    |Cards       |George Goomba
    67    |Cards       |David Janssen
    69    |Cards       |Edward Erdman
    71    |Cards       |Don Allison
    73    |Cards       |Carl Marin
    75    |Cards       |Larry Lintos
    77    |Cards       |Tim Lentleson
    79    |Cards       |Carl Vanamos
    81    |Cards       |Steve Mossely
    83    |Cards       |Manny Stolanaro
    85    |Cards       |Michael Hillson
    87    |Cards       |Neil Gaston
    89    |Cards       |Mo Grandosi
    91    |Cards       |Mark Hasty
    93    |Cards       |Stephen Tuvesco

    47 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) data type

</div>
</section>
