import sedaro.deserialize
import sedaro.serialize
import sedaro.Secrets

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Function definitions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get a simulation
function response = get_simulation(host, api_key, branch_id, job_id)
    url = strcat(host, '/simulations/branches/', branch_id, '/control/', job_id);
    headers = {'X_API_KEY', api_key};
    options = weboptions('HeaderFields', headers);
    response = webread(url, options);
end

% Start a simulation
function response = start_simulation(host, api_key, branch_id)
    url = strcat(host, '/simulations/branches/', branch_id, '/control');
    headers = {'X_API_KEY', api_key; 'Content-Type', 'application/json'};
    options = weboptions('HeaderFields', headers, 'RequestMethod', 'post');
    body = struct();  % Create an empty struct for the request body
    response = webwrite(url, body, options);
end

% Terminate a simulation
function response = terminate_simulation(host, api_key, branch_id, job_id)
    % Construct the URL for DELETE request
    url = strcat(host, '/simulations/branches/', branch_id, '/control/', job_id);
    headers = {'X_API_KEY', api_key};
    options = weboptions('HeaderFields', headers, 'RequestMethod', 'delete');
    response = webwrite(url, options);
end

% Produce `values` to a running simulation
function put_externals(host, api_key, job_id, agent_id, external_state_id, values)
    payload = struct();
    payload.values = sedaro.serialize(values);
    values_json = jsonencode(payload);
    url = strcat(host, '/simulations/jobs/', job_id , '/externals/', agent_id, '/', external_state_id);
    headers = {'X_API_KEY' api_key; 'Content-Type' 'application/json'};
    options = weboptions('HeaderFields', headers, 'RequestMethod', 'patch');
    webwrite(url, values_json, options);
end

% Consume `values` from a running simulation
function response = get_externals(host, api_key, job_id, agent_id, external_state_id)
    url = strcat(host, '/simulations/jobs/', job_id , '/externals/', agent_id, '/',  external_state_id);
    headers = {'X_API_KEY' api_key};
    options = weboptions('HeaderFields', headers);
    response = webread(url, options);
    response = sedaro.deserialize(response);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Using the defined functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create an instance of Secrets
secrets = Secrets();
host = secrets.get('URL');
api_key = secrets.get('API_KEY');
agent_id = secrets.get("AGENT_EXTERNAL_ID");
external_state_id = secrets.get("EXTERNAL_STATE_BLOCK_ID");
branch_id = secrets.get("WILDFIRE_SCEN_ID");

% Start a simulation
response = start_simulation(host, api_key, branch_id);

job_id = response.id;

% Display simulation
disp(response);

% Poll simulation until status == RUNNING
status = '';
while (strncmp(status,'RUNNING',7) == false)
    % Get simulation job status
    simulation = get_simulation(host, api_key, branch_id, job_id);
    status = simulation.status;
    fprintf('Waiting for simulation to start (ID: %s). Current status: `%s`\n', job_id, status);
    pause(1);
end

disp('Simulation started.');

% Simple cosimulation example
counter = 0;
while(counter<10)
    if(mod(counter, 2))
        attitude = [1, 0, 0, 0];
    else
        attitude = [0, 1, 0, 0];
    end
    rates = [0, 0, 0];
    put_externals(host, api_key, job_id, agent_id, external_state_id, {attitude, rates});

    result = get_externals(host, api_key, job_id, agent_id, external_state_id);
    disp("get_externals: ");
    time = result{1}
    
    reaction_wheel_torques1 = result{2}{1}
    reaction_wheel_torques2 = result{2}{2}
    reaction_wheel_torques3 = result{2}{3}
    
    magnetorquer_values = result{3}
    counter= counter+1;
    pause(5);
end

% Terminate simulation
terminate_simulation(host, api_key, branch_id, job_id);
disp('Simulation terminated.');