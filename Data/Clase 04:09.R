library(tidyverse)
students <- read_csv("data/students.csv")
students |> 
  rename(
    student_id = `Student ID`,
    full_name = `Full Name`
  )
#> # A tibble: 6 × 5
#>   student_id full_name        favourite.food     mealPlan            AGE  
#>        <dbl> <chr>            <chr>              <chr>               <chr>
#> 1          1 Sunil Huffmann   Strawberry yoghurt Lunch only          4    
#> 2          2 Barclay Lynn     French fries       Lunch only          5    
#> 3          3 Jayendra Lyne    <NA>               Breakfast and lunch 7    
#> 4          4 Leon Rossini     Anchovies          Lunch only          <NA> 
#> 5          5 Chidiegwu Dunkel Pizza              Breakfast and lunch five 
#> 6          6 Güvenç Attila    Ice cream          Lunch only          6

students |> janitor::clean_names()
#> # A tibble: 6 × 5
#>   student_id full_name        favourite_food     meal_plan           age  
#>        <dbl> <chr>            <chr>              <chr>               <chr>
#> 1          1 Sunil Huffmann   Strawberry yoghurt Lunch only          4    
#> 2          2 Barclay Lynn     French fries       Lunch only          5    
#> 3          3 Jayendra Lyne    <NA>               Breakfast and lunch 7    
#> 4          4 Leon Rossini     Anchovies          Lunch only          <NA> 
#> 5          5 Chidiegwu Dunkel Pizza              Breakfast and lunch five 
#> 6          6 Güvenç Attila    Ice cream          Lunch only          6

read_csv(
  "a,b,c
  1,2,3
  4,5,6"
)
#> Warning: The `file` argument of `read_csv()` should use `I()` for literal data as of
#> readr 2.2.0.
#>   
#>   # Bad (for example):
#>   read_csv("x,y\n1,2")
#>   
#>   # Good:
#>   read_csv(I("x,y\n1,2"))
#> # A tibble: 2 × 3
#>       a     b     c
#>   <dbl> <dbl> <dbl>
#> 1     1     2     3
#> 2     4     5     6 


