# How to get the merge commit proportion?

1. Go to the git repository to analyse
2. Run `count-merge-commits.sh $REPOSITORY_FOLDER $BRANCH_NAME`
3. This will generate a file `commits_per_month.csv` and `commits.csv`.
   The first one contains this data

```
date    ,total commits,merge commits
2022-10 ,52           ,27
2022-11 ,165          ,59
2022-12 ,83           ,41
```

and `commits.csv` contains the raw data that can be used to fact check manually.

```
date      ,month   ,hash                                    ,author        ,type  ,message
2023-07-19,2023-07 ,099f359074f9f63f65ae091d60c70f0722cdecde,Arnaud CLAUDEL,normal,direct commit after merge
2023-07-19,2023-07 ,319b8378654a9858798e1279cbfdcefcd84044fe,Arnaud CLAUDEL,normal,second change on feature
2023-07-19,2023-07 ,26680cca5befcb18f787b548c21132f7fbdfab34,Arnaud CLAUDEL,normal,change on feature branch
2023-07-19,2023-07 ,32f421c2224e9a984742e34c08a4aba5685bfa10,Arnaud CLAUDEL,normal,direct commit
```

4. Copy this to a google sheet
5. Sort the entries by date descending
6. Select the whole tab and generate an `area chart`
   - date in X-axis
   - 2 series for total commits and merge commits
