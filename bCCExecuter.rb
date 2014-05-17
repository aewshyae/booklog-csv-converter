# encoding:utf-8
$:.unshift File.dirname(__FILE__) 
require 'booklogCsvConverter'
Shoes.app do 
  conv = BooklogCsvConverter.new
    stack(margin: 6) do
        title "Booklog CSV File Converter"
            para "This app converts csv files downloaded from Booklog's 'Exports' to Japanese Vertical Bibliography Style."
    end 
    stack(margin: 12) do
        para "Push the button below."
        flow do
          button ("Execute") do
            filename=ask_open_file
            debug(filename)
            if filename!=nil 
              conv.converter filename
            end
          end
        end
    end
end
