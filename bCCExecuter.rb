# encoding:utf-8
$:.unshift File.dirname(__FILE__) 
require 'booklogCsvConverter'
Shoes.app :title => "ブクログCSV変換アプリ", :font => "HGSMinchoE", :width => 400, :height => 300 do 
    background "#EFC"
    stack(margin: 6) do
        title "ブクログCSV変換", :font => "HGMaruGothicMPRO"
        para "ブクログのエクスポート機能でダウンロードしたCSVファイルを、日本語縦書の参考文献の書式に変換してファイルに書き出すアプリです。", :font => "HGMaruGothicMPRO"
    end 
    stack(margin: 8) do
        conv = BooklogCsvConverter.new
        flow do
          button "実行" , :font =>"HGMaruGothicMPRO", :width=>100 do
            filename=ask_open_file
            debug filename.to_s
            if !filename.to_s.empty? 
              conv.converter( filename, @paraDir.text)
            end
          end
        end
        dirname=File.expand_path('~')
        flow do
          button "出力先指定", :font =>"HGMaruGothicMPRO", :width=>100 do
            dirname=ask_open_folder
            debug dirname.to_s
            if !dirname.to_s.empty? 
              @paraDir.text = dirname
            end
          end
          @paraDir= para dirname, :font =>"HGMaruGothicMPRO", :size=>10, :height=>10
        end
        para "ブクログ CSVエクスポート", (link "http://booklog.jp/export/csv", :click=>"http://booklog.jp/export/csv"), :font=>"HGMaruGothicMPRO"
    end
end
