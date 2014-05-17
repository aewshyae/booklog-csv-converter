# encoding:utf-8
require 'booklogCsvConverter'
Shoes.app do 
    stack(margin: 6) do
        title "Booklog CSV File Converter"
            para "This app converts csv files downloaded from Booklog's 'Exports' to Japanese Vertical Bibliography Style."
    end 
    stack(margin: 12) do
        para "Push the button below."
        flow do
          button ("Execute") do
            filename=ask_open_file
          end
        end
    end
end
