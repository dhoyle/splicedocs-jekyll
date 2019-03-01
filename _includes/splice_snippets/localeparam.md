
Locale
{: .paramName}

Optional. You can specify the locale (language and country) to perform language-specific conversions. If you don't supply this parameter, the *Java Session locale* value, which is automatically detected, is used as your locale.
{: .paramDefnFirst}

You must specify the locale using the following format: `ll_CC`, where:
{: .paramDefn}

<ul class="nested">
<li><p><code>ll</code> is a lowercase, two-character ISO-639 language name code.</p>
    <p>Some examples are: <code>de</code> for German, <code>en</code> for English, <code>es</code> for Spanish, and <code>ja</code> for Japanese. You can see a list of the ISO-639 codes here: <a href="https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes" target="_blank">https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes</a>.</p></li>

<li><p><code>CC</code> is an uppercase, two-character ISO-3166 country code.</p>
    <p>Some examples are <code>DE</code> for Germany, <code>US</code> for the United States, <code>ES</code> for Spain, and <code>JP</code> for Japan.  You can see a list of the ISO-3166 codes here: <a href="https://en.wikipedia.org/wiki/ISO_3166-1" target="_blank">https://en.wikipedia.org/wiki/ISO_3166-1</a>.</p></li>
</ul>

For example, you can use `de_DE` to specify that German language rules should be used when applying this function, or you could specify `en_US` to apply American English rules.
{: .paramDefn}
