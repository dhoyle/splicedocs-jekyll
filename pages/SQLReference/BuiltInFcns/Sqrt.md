---
title: SQRT built-in SQL function
summary: Built-in SQL function that returns the square root of a number
keywords: 
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_builtinfcns_sqrt.html
folder: SQLReference/BuiltInFcns
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SQRT

The `SQRT` function returns the square root of a floating point number.

To execute `SQRT` on data types other than floating point numbers, you
must first cast them to floating point types.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SQRT(FloatingPointExpression)
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
FloatingPointExpression
{: .paramName}

A &nbsp;[`DOUBLE PRECISION`](sqlref_datatypes_doubleprecision.html) number.
{: .paramDefnFirst}

</div>
## Results

The return type for `SQRT` is the type of the input parameter value.

## Examples

<div class="preWrapperWide" markdown="1">
    splice> VALUES sqrt(3421E+09);
    1
    ----------------------
    1849594.5501649815
    
    1 row selected
    
               -- Shows using SQRT on a SMALLINT column
    splice> select Strikeouts, SQRT(Strikeouts) "SQRT"
       FROM Batting
       WHERE Strikeouts > 50
       ORDER BY Strikeouts;
    STRIK&|SQRT
    -----------------------------
    52    |7.211102550927978
    56    |7.483314773547883
    59    |7.681145747868608
    59    |7.681145747868608
    59    |7.681145747868608
    76    |8.717797887081348
    90    |9.486832980505138
    93    |9.643650760992955
    95    |9.746794344808963
    96    |9.797958971132712
    110   |10.488088481701515
    111   |10.535653752852738
    119   |10.908712114635714
    121   |11.0
    147   |12.12435565298214
    151   |12.288205727444508
    
    16 rows selected
    
    splice> SELECT ID, FieldingIndependent, SQRT(FieldingIndependent) "SQRT"
       FROM Pitching
       WHERE Mod(ID, 2)=1;
    ID    |FIELDI&|SQRT
    -------------------------------------
    29    |4.02   |2.004993765576342
    31    |4.53   |2.1283796653792764
    33    |4.29   |2.071231517720798
    35    |4.83   |2.1977260975835913
    37    |3.90   |1.9748417658131499
    39    |4.02   |2.004993765576342
    41    |1.91   |1.3820274961085253
    43    |3.36   |1.833030277982336
    45    |4.81   |2.1931712199461306
    47    |3.13   |1.7691806012954132
    73    |3.21   |1.7916472867168918
    75    |3.44   |1.8547236990991407
    77    |4.53   |2.1283796653792764
    79    |3.74   |1.9339079605813716
    81    |3.78   |1.944222209522358
    83    |2.76   |1.6613247725836149
    85    |5.39   |2.32163735324878
    89    |8.38   |2.894822965226026
    91    |4.63   |2.151743479135001
    93    |3.82   |1.9544820285692064
    
    20 rows selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [About Data Types](sqlref_datatypes_numerictypes.html)

</div>
</section>

