GET REVIEWED:

    onprem_info_requirements.html
    onprem_info_editions.html
    onprem_install_links.html

BUILD:

    UPDATE SwiftType search
    verify robots.txt
    UPDATE .htaccess:
        Redirect 301 /developers_tuning_explainplan_examples.html https://doc.splicemachine.com/bestpractices_optimizer_explain.html
        Redirect 301 /developers_tuning_developers_tuning_explainplan.html https://doc.splicemachine.com/bestpractices_optimizer_explain.html
        Redirect 301 /developers_tuning_queryoptimization.html https://doc.splicemachine.com/bestpractices_optimizer_hints.html
        Redirect 301 /developers_tuning_usingstats.html https://doc.splicemachine.com/bestpractices_optimizer_statistics.html
        Redirect 301 /tutorials_indexing_largeindex.html https://doc.splicemachine.com/bestpractices_optimizer_indexes.html
        Redirect 301 /notes_usingdocs.html https://doc.splicemachine.com/gettingstarted_usingdocs.html
        Redirect 301 /getstarted.html https://doc.splicemahicne.com/gettingstarted_intro.html
        Redirect 301 /developers_fundamentals_compaction.html https://doc.splicemachine.com/bestpractices_optimizer_compacting.html


        Update the sitemapindex.xxx.xml files for the new version
                Add a new sitemap to the set of sitemaps in sitemapindex.docstest.xml, and (when ready to go live) to sitemapindex.doc.xml.  You can also do this in docsdev, but its site index doesn't get used, so it does no good (but does no harm).

                For example, this:
                    <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
                      <sitemap>
                        <loc>https://docstest.splicemachine.com/2.7/sitemap.2.7.xml</loc>
                      </sitemap>
                      <sitemap>
                        <loc>https://docstest.splicemachine.com/2.5/sitemap.2.5.xml</loc>
                      </sitemap>
                    </sitemapindex>

                Becomes this:
                    <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
                      <sitemap>
                        <loc>https://docstest.splicemachine.com/sitemap.2.8.xml</loc>
                      </sitemap>
                      <sitemap>
                        <loc>https://docstest.splicemachine.com/2.7/sitemap.2.7.xml</loc>
                      </sitemap>
                      <sitemap>
                        <loc>https://docstest.splicemachine.com/2.5/sitemap.2.5.xml</loc>
                      </sitemap>
                    </sitemapindex>


REVIEW:
    https://docstest.splicemachine.com/onprem_info_requirements.html

    https://docstest.splicemachine.com/onprem_install_links.html

    FRONT PAGE HIGHLIGHTING NEW FEATURES

    ONPREM FRONT PAGE

    RELEASE NOTES
