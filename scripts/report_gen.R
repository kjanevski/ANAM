test_list <- c("m2s","moo","mth","slp")

for(i in 1:length(test_list)){
  test_type <- test_list[i]
  
  rmarkdown::render(input = "report_template.Rmd", 
                    output_file = sprintf(paste0('reports/',test_type,"_report.html")),
                    params = list(test_type = test_type, new_title = paste0("ANAM - ",test_type)))
}
