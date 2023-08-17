source('code/loop_functions.R')

results <- microbenchmark::microbenchmark(loop_rMarkdown(), 
                                          loop_rQuarto_1(), 
                                          loop_rQuarto_2(),
                                          times = 10)

write.csv(results, file = "results.csv")