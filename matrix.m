clc; clear

row = 40;
col = 130;

chars = char (randi ([33 126], row, col));
len = randi (row-1, 1, col); % length of each column
fw = logical (randi ([0 1], 1, col)); % forward raining code

% initialize raining code (rc)
rc (1:row, 1:col) = ' ';

for j = 1:col
    if fw(j)
        rc (1:len(j), j) = chars (1:len(j), j);
    else
        rc (len(j)+1:row, j) = chars (len(j)+1:row, j);
    end
end

% display raining code for the first time
disp (rc)
clear rc

while true
    fprintf ('\033[%d;%dH', row+1, 1)
    pause (0.1)

    len = len+1; % update len

    for j = 1:col
        if fw(j) 
            fprintf ('\033[%d;%dH%c', len(j), j, chars (len(j), j)) % display raining characters
        else
            fprintf ('\033[%d;%dH ', len(j), j) % overwrite raining characters with a space
        end

        if len(j) == row 
            fw(j) = ~fw(j); % if len == row, change direction, i.e. move backward instead of forward and viceversa
            len(j) = 0; % reset len to 0
        end 
    end
end