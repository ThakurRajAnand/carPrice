source('utils.R')

#Read Data
data <- fread('../Data/imports-85.data.txt',stringsAsFactors = FALSE)
columnNames <- c('symboling','normalized_losses','make','fuel_type',
                 'aspiration','num_of_doors','body_style','drive_wheels',
                 'engine_location','wheel_base','length','width',
                 'height','curb_weight','engine_type','num_of_cylinders',
                 'engine_size','fuel_system','bore','stroke',
                 'compression_ratio','horsepower','peak_rpm','city_mpg',
                 'highway_mpg','price')

names(data) <- columnNames
data$normalized_losses <- as.numeric(data$normalized_losses)
data$bore <- as.numeric(data$bore)
data$stroke <- as.numeric(data$stroke)
data$horsepower <- as.numeric(data$horsepower)
data$peak_rpm <- as.numeric(data$peak_rpm)
data$price <- as.numeric(data$price)


#Write to train.csv
fwrite(data,'../Data/train.csv')

#Exploratory Data Analysis
EDA <- df_status(data)
fwrite(EDA,'../Data/EDA.csv')


