# How to get the contribution repartition?

1. Go to the git repository to analyse
2. Run `1-list-commits.sh`
3. This will generate a file `commit_count_per_month.csv` containing this

```csv
date,commit count,author
2023-07,6,john@gmail.com
2023-07,9,jane@gmail.com
2023-07,2,jake@gmail.com
2023-06,8,john@gmail.com
2023-06,1,jake@gmail.com
2023-05,1,john@gmail.com
```

4. Move the csv file in a local folder, for instance `examples/trivial`

5. Run `2-create-repartition-matrix.csv`
6. This will generate `repartition-matrix.csv`

```csv
date,jane@gmail.com,john@gmail.com,jake@gmail.com
2023-05,,1,
2023-06,,8,1
2023-07,9,6,2
```

7. Import this to Excel
8. Select the whole tab and generate a `100% stacked area chart`
9. Set x-axis to `date` and series to individual developers

Further Refinement:

- some developers could have the same email address
- there could be some bots (e.g. Dependabot)
- you might want to regroup unfrequent contirbutors to simplify the chart
- ex-developers could be grey out to only highlight the active ones
