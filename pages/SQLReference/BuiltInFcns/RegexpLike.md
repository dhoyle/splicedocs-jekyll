---
title: REGEXP_LIKE operator
summary: Built-in SQL function that determines if a source string matches a regular expression pattern
keywords: regexp, like
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_builtinfcns_regexplike.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# REGEXP_LIKE Operator

The `REGEXP_LIKE` operator returns `true` if the string matches the
regular expression. This function is similar to the `LIKE` predicate,
except that it uses regular expressions rather than simple wildcard
character matching.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    REGEXP_LIKE( sourceString, patternString )
    }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
sourceString
{: .paramName}

The character expression to match against the regular expression.
{: .paramDefnFirst}

patternString
{: .paramName}

The regular expression string used to search for a match in <span
class="CodeItalicFont">sourceString</span>.
{: .paramDefnFirst}

The pattern is a `java.util.regex` pattern. You can find documentation
for the JDK 8 version
here: [http://docs.oracle.com/javase/8/docs/api/java/util/regex/package-summary.html][1]{:
target="_blank"}.
{: .paramDefn}

</div>
## Results

Returns true if the <span class="CodeItalicFont">sourcestring</span> you
are testing matches the specified regular expression in <span
class="CodeItalicFont">patternString</span>.

## Examples

The following query finds all players whose name begins with *Ste*:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> SELECT DisplayName
       FROM Players
       WHERE REGEXP_LIKE(DisplayName, '^Ste.*');
    
    DISPLAYNAME
    ------------------------
    Steve Raster
    Steve Mossely
    Stephen Tuvesco
    
    3 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)
* [`CONCATENATION`](sqlref_builtinfcns_concat.html) operator
* [`INITCAP`](sqlref_builtinfcns_initcap.html) function
* [`INSTR`](sqlref_builtinfcns_instr.html) function
* [`LCASE`](sqlref_builtinfcns_lcase.html) function
* [`LENGTH`](sqlref_builtinfcns_length.html) function
* [`LTRIM`](sqlref_builtinfcns_ltrim.html) function
* [`REPLACE`](sqlref_builtinfcns_replace.html) function
* [`RTRIM`](sqlref_builtinfcns_rtrim.html) function
* [`SUBSTR`](sqlref_builtinfcns_substr.html) function
* [`TRIM`](sqlref_builtinfcns_trim.html) function
* [`UCASE`](sqlref_builtinfcns_ucase.html) function

</div>
</section>



[1]: http://docs.oracle.com/javase/8/docs/api/java/util/regex/package-summary.html
