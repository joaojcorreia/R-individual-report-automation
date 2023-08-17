source('code/analysis_funct.R')


#RMarkdown#

loop_rMarkdown <- function(){

  n <- nrow(full_data)
  a <- 1
  
  while(a <= n ){
    
    cat(a,' out of ',n)
    select.individual(a)
    rmarkdown::render(input = "rmarkdown/report_template.Rmd", output_file = 'report.pdf')
    name_file <- as.character(
      str_glue(
        str_replace_all(ind_data[1,8], " ", "."),
        "pdf", .sep="."))
    file.rename( 'rmarkdown/report.pdf', str_glue('reports_rmarkdown/',name_file))
    a <- a+1
  }
  
}
    
#RQuarto 1 - data exported to all_data.RData and then loaded in the Quarto file#

loop_rQuarto_1 <- function(){
  
  n <- nrow(full_data)
  a <- 1

  
  while(a <= n ){
    
    cat(a,' out of ',n)
    select.individual(a)
    save.image(file="rquarto/all_data.RData") 
    params <- list(subtitle = as.character(ind_data[,8]))
    quarto::quarto_render("rquarto/report_template.qmd", output_format = "pdf", 
                          output_file = "report.pdf", execute_params = params)
    name_file <- as.character(
      str_glue(
        str_replace_all(ind_data[1,8], " ", "."),
        "pdf", .sep="."))
    file.rename( 'report.pdf', str_glue('reports_rquarto_1/',name_file))
    rm(params)
    a <- a+1
  }
  
}

loop_rQuarto_2 <- function(){
  
  n <- nrow(full_data)
  a <- 1
  
  
  while(a <= n ){
    
    cat(a,' out of ',n)
    select.individual(a)
    full_file_path <- file.path(getwd(), "code", "analysis_funct.R")
    params <- list(subtitle = as.character(ind_data[,8]), c = a, dir_file = full_file_path)
    quarto::quarto_render("rquarto/report_template_2.qmd", output_format = "pdf", 
                          output_file = "report.pdf", execute_params = params)
    name_file <- as.character(
      str_glue(
        str_replace_all(ind_data[1,8], " ", "."),
        "pdf", .sep="."))
    file.rename( 'report.pdf', str_glue('reports_rquarto_2/',name_file))
    rm(params)
    a <- a+1
  }
  
}
