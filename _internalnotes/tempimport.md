The [SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html) system procedure has largely replaced the use of `SYSCS_UTIL.COMPUTE_SPLIT_KEY` and `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS` procedures; it combines those two procedures into one with a simplified interface. We strongly encourage you to use [SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html) instead of this procedure.
{: .noteIcon}

For more information about splitting your tables and indexes into HFiles, see the [Splitting Input Data](tutorials_ingest_importsplit.html) section of our *Importing Data* tutorial.



  We strongly encourage you to use the simpler &nbsp;`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX` procedure instead of using `SYSCS_UTIL.COMPUTE_SPLIT_KEY` combined with `SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX_AT_POINTS`.
  {: .noteIcon}





If you have specified `skipSampling=true` to indicate that you're using &nbsp;
 &nbsp;[`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) to compute the split keys, the parameter values that you pass to tthat procedures must match the values  that you pass to this procedure.
{: .noteNote}



                                    <li><a href="{{folderitem.external_url | replace: 'splice.build.version', {{site.build_version}} | upcase }}" target="_blank">{{folderitem.title}}</a></li>
