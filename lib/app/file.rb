require 'csv'
require 'fileutils'
require './app/basefunction'

class Readfile
    attr_accessor :csv_data, :header
    def initialize(data)
        @csv_data = CSV.read('../data/'+data)[1..-1]
        @header = CSV.read('../data/'+data, {headers: true, return_headers: true})[0]
    end
end

class DelelteColumn
    attr_accessor :csv_data, :csv, :header
    attr_reader :not_exist_staton

    def initialize(csv)
        @csv = csv
        @not_exist_staton = CSV.read("../appendix/delete_station.csv").shift
        @header = CSV.read('../data/'+csv, {headers: true, return_headers: true})[0]
    end

    def loop_delete
        CSV.open('../data/'+BaseFunction.base_name(@csv)+"_later.csv", 'wb') do |csv|
            csv << @header #append header
            CSV.foreach('../data/' + @csv, {headers: true, return_headers: true}) do |row|
                if find_unsuitable(row)
                    csv << row
                end
            end
        end
    end

    def delete_column(name)
        @csv_data.delete(name)
    end

    def find_unsuitable(row)
        if delete_station(row) #if true
            return false
        elsif delete_time(row)
            return false
        else
            return true
        end
    end
    def delete_station(e)
        return (@not_exist_staton.include? e["借車站代號"]) || (@not_exist_staton.include? e["還車站代號"])
    end

    def delete_time(e)
        begin
            time = Time.parse(e["租用(分)"])
            if time.hour == 0 && time.min <5
                return true
            end
        rescue
            return true
        end
    end
end
