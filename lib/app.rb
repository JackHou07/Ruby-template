require 'time'
require 'time_seg'
require './app/file'


file_array = Dir.entries('../data/').reject{|entry| entry == "." || entry == ".." || entry ==".DS_Store"}
for i in 0 ... (file_array.size)
    del_file = DelelteColumn.new(file_array[i])
    del_file.loop_delete
end
