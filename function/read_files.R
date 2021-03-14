# read data of different format 
read_files <- function(input_file_chart) {
   ext <- tools::file_ext(input_file_chart)
   ext = switch(
      ext, 
      xlsx = readxl::read_xlsx(input_file_chart), 
      xls = readxl::read_xls(input_file_chart), 
      csv = vroom::vroom(input_file_chart),
      tsv = vroom::vroom(input_file_chart, delim = '\t'),
      validate("Invalid file; Please upload a .xlsx, .xls, .csv or .tsv file")
   )
   return(ext)
}

