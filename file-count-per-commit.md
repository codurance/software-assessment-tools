# How to get the average count of files changed?

1. Go to the git repository to analyse
2. Run `file-count-per-commit.sh $REPOSITORY_FOLDER $BRANCH_NAME`
3. This will generate a file `file_count_per_commit.csv` and `file_count_per_commit_excluded.csv`.
   The first one contains this data

```
hash                                    ,date      ,files changed,author,message
43d0131ed6bfefded9468361228f5ac16e18fcef,2023-07-06,2            ,Bob   ,"a commit with 2 files changed"
4ce5fc4bc346bf4b2a096c53cf1d9e3f4e359de0,2023-07-05,3            ,Jane  ,"another commit with 3 files changed"
```

and the other has the same format but will contain the excluded files.
Commits above with more than 30 files (30 is the default at the time of writing) will go to this exclusion file.
You can see the actual value at the top of the script.

This exclusion is meant to remove large irrelevant administrative commits, such as a git init, package rename or move etc. If you wish to include all the commits, then put this value to a very large number.

5. Go quickly through the exclusion files to have judge if the default value is relevant.

- If the file is empty, skip this step
- If the file only contains a couple commits about the git init or similar one-time thing, skip this step
- If you see a large number of commits, where the commit message seems to be about normal work, then it might indicates that the threshold is too low. Try to get a grasp of the size and increase it to get an accurate result.

For example, on a project we started at 30, but realized that some legit commits where changing 30-40 files, so we raised it to 41.

Re-run the script and repeat the exclusion verficiation step until you feel confident that the result seems relevant.

4. Copy this to a google sheet
5. Generate a graph for the entire timeline
6. Select the whole tab and generate an `area chart`
   - author in X-axis (tick the 'Aggregate' box)
   - 'average' files changed in series
7. Calculate the average file changed count, the formula is the following, simply adjust the data range to your sheet.

```
=ROUND(AVERAGE(C2:C2443))
```

8. Do the same again for recent work only (pick an arbitrary date, the last 3 months)
   - generate the graph
   - generate the average file changed count
