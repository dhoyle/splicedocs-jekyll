{% comment %}
--> COMMENTED OUT by GRH 3/20/2019

#### Relative Complexity and Performance Table

The following table summarizes the relative performance, complexity, and functionality of our flat file ingestion methods:

<table>
    <col width="10%" />
    <col width="24%" />
    <col width="10%" />
    <col width="10%" />
    <col width="23%" />
    <col width="23%" />
    <thead>
        <tr>
            <th>Type</th>
            <th>Import Method</th>
            <th>Complexity</th>
            <th>Performance</th>
            <th>Pros</th>
            <th>Cons</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2"><code>BULK_HFILE_IMPORT</code></td>
            <td>Automatic splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;&#x2713;</td>
            <td><p>Enhanced performance</p>
                <p>Low complexity</p>
            </td>
            <td>No constraint checking</td>
        </tr>
        <tr>
            <td>Manual Splitting</td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;&#x2713;&#x2713;</td>
            <td><p>Best performance, especially for large datasets</p>
            </td>
            <td><p>No constraint checking</p>
                <p>You must determine the key values to split your data evenly</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">Basic</td>
            <td><code>IMPORT_DATA</code></td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;</td>
            <td><p>Constraint checking</p>
                <p>Best for pulling in small datasets of new records</p>
            </td>
            <td><p>Slower for very large datasets</p>
            </td>
        </tr>
        <tr>
            <td><code>MERGE_DATA_FROM_FILE</p>
            </td>
            <td class="spliceCheckboxBlue">&#x272F;&#x272F;</td>
            <td class="spliceCheckboxBlue">&#x2713;&#x2713;</td>
            <td><p>Constraint checking</p>
                <p>Updates existing records in addition to adding new records</p>
            </td>
            <td><p>Slower than <code>IMPORT_DATA</code></p>
                <p>Table must have primary key</p>
            </td>
        </tr>
    </tbody>
</table>
{% endcomment %}
