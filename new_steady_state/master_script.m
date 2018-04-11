list = dir;
A = {list.name};
one = {};three = {};nine = {}; zero = {};
%Sorting into different lists
for i=17:74
    str = A{i};
    newStr = extractAfter(str, strlength(str)-5);
    if(newStr == '1.mat')
        one{end+1} = str;
    end
    if(newStr == '3.mat')
        three{end+1} = str;
    end
    if(newStr == '9.mat')
        nine{end+1} = str;
    end
    if(newStr == '0.mat')
        zero{end+1} = str;
    end
 
end

final_table_0 = zeros(4,5);
final_table_25 = zeros(4,5);
final_table_50 = zeros(4,5);
final_table_75 = zeros(4,5);
final_table_100 = zeros(4,5);
nums = {'zero', 'one', 'three', 'nine'};
    
    %perc_check is the INDEX of % match required, 2 implies 25%, 
    perc_check = 2;
    
    %t_label is the INDEX of the label we are calculating the accuracy for,
    %also change label name where getting File
    t_label = 3;
    for dict_size = 1:2
        
        test_size = 12-dict_size;

        %generate an array of indices to set aside for dictionary
        arr_indices = [];
    
        for random_index = 1:dict_size
            temp_random = randi([1,12]);
            while(ismember(temp_random, arr_indices))
                temp_random = randi([1,12]);
            end
            arr_indices(end+1) = temp_random;
        end
    
        zero_dict = {};
        one_dict = {};
        three_dict = {};
        nine_dict = {};
    
        for index = 1:dict_size
            zero_dict{end+1} = zero{arr_indices(index)};
            one_dict{end+1} = one{arr_indices(index)};
            three_dict{end+1} = three{arr_indices(index)};
            nine_dict{end+1} = nine{arr_indices(index)};
        end
    
 
     
        %append all files with the index in this array to become dictionary
        append_all(zero_dict, dict_size, 'zero');
        append_all(one_dict, dict_size, 'one');
        append_all(three_dict, dict_size, 'three');
        append_all(nine_dict, dict_size, 'nine');
    
        
        similarity_t_label = 0;
        total_correct_perc_check = 0;

        test_indices = [];
        %compare all other files with the dictionary zero
        for test_number = 1:test_size
        
            %Pick a random file
            temp_random_two = randi([1,12]);
        
            while(ismember(temp_random_two, arr_indices) || ismember(temp_random_two, test_indices))
                temp_random_two = randi([1,12]);
            end
        
            %Append file name 
            test_indices(end+1) = temp_random_two;
            
            %Get file
            File = three{temp_random_two};
       
            %Run against all dictionaries
                
            test_vals = {};
            test_vals{1} = analytics_dynPerc_compare_seq(File, 'dict_zero.mat');
            test_vals{2} = analytics_dynPerc_compare_seq(File, 'dict_one.mat');
            test_vals{3} = analytics_dynPerc_compare_seq(File, 'dict_three.mat');
            test_vals{4} = analytics_dynPerc_compare_seq(File, 'dict_nine.mat');
            
            
                max_val = max(test_vals{1}(perc_check),test_vals{2}(perc_check));
                max_val = max(max_val,test_vals{3}(perc_check));
                max_val = max(max_val,test_vals{4}(perc_check));

                if (max_val == test_vals{t_label}(perc_check))
                   total_correct_perc_check =  total_correct_perc_check + 1;
                end
            end

        final_table_75(t_label, dict_size) = total_correct_perc_check/test_size;
           
        end
           
        
        


