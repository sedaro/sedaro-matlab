function result = is_struct_array(input)
    if isstruct(input)
        % Check if input is also an array (more than one element)
        if numel(input) > 1
            result = 1; % Input is a struct array
        else
            result = 0; % Input is a single struct
        end
    else
        result = 0; % Input is not a struct
    end
end
