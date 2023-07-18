# How to get the contribution repartition?

1. Go to the git repository to analyse
2. Run `list-commits.zsh`
3. This will generate a file `commit_count_per_month.csv` containing this

```
date,commit count,author
2023-07,6,john@gmail.com
2023-07,9,jane@gmail.com
2023-07,2,jake@gmail.com
2023-06,8,john@gmail.com
2023-06,1,jake@gmail.com
2023-05,1,john@gmail.com
```

4. Copy this to a google sheet
5. Sort the entries by email

```
date,commit count,author
2023-07,2,jake@gmail.com
2023-06,1,jake@gmail.com
2023-07,9,jane@gmail.com
2023-07,6,john@gmail.com
2023-06,8,john@gmail.com
2023-05,1,john@gmail.com
```
6. Create a new tab and re-arrange the rows in a double entry table like this one:

```
date	jake@gmail.com jane@gmail.com john@gmail.com
2023-07	2                   9               6
2023-06	1                                   8
2023-05	                                    1
```

7. Select the whole tab and generate a `100% stacked area chart`
8. Get the list of active / former developers and grey out all the former developers
