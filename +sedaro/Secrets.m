classdef Secrets
    properties (Access = private)
        prop % Property to store loaded properties
    end
    
    methods
        % Constructor
        function obj = Secrets()
            obj.prop = obj.openFile();
        end
        
        % Helper method to open config.properties file
        function prop = openFile(obj)
            % Get current directory
            currentDir = fileparts(mfilename('fullpath'));
            
            % Construct file path to config.properties in current directory
            filePath = fullfile(currentDir, 'config.properties');
            
            % Initialize a struct to store properties
            prop = struct();
            
            % Open the file for reading
            fid = fopen(filePath, 'r');
            if fid == -1
                error('Failed to open file: %s', filePath);
            end
            
            % Read all lines from the file
            lines = textscan(fid, '%s', 'Delimiter', '\n');
            lines = lines{1};
            
            % Close the file
            fclose(fid);
            
            % Process each line to extract key-value pairs
            for i = 1:numel(lines)
                line = lines{i};
                if ~isempty(line) && ~startsWith(line, '#')  % Ignore comments
                    % Split line into key and value
                    parts = strsplit(line, '=', 'CollapseDelimiters', false);
                    if numel(parts) == 2
                        % Trim leading/trailing whitespace from key and value
                        key = strtrim(parts{1});
                        value = strtrim(parts{2});
                        % Store key-value pair in struct
                        prop.(key) = value;
                    end
                end
            end
        end
        
        % Getter method to get a value corresponding to a given key
        function value = get(obj, key)
            if isfield(obj.prop, key)
                value = obj.prop.(key);
            else
                error('Key "%s" not found in properties file.', key);
            end
        end
    end
end