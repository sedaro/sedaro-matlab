# sedaro-matlab
A Sedaro cosimulation client for MATLAB
This document explains the steps to start working with your Matlab client for consumption of Sedaro services.

Read more about Sedaro at [docs.sedaro.com](https://docs.sedaro.com).

### API Key

To access the Sedaro service via this API, you will need an API key.  You can generate an API key for your account in the
Sedaro [Management Console](https://satellite.sedaro.com/account). Once complete, pass the API key in all requests
via the `X_API_KEY` HTTP header.

*API keys grant full access to your account and should never be shared. If you think your API key has been compromised,
you can revoke it in the [Management Console](https://satellite.sedaro.com/account).*

### Community, Support, Discussion

If you have any issues or suggestions, please reach out:

1. Join the Sedaro Community [Slack](https://join.slack.com/t/sedaro-community/shared_invite/zt-1jps4i711-mXy88AZQ9AV7YcEXr8x7Ow)
2. Email us at support@sedarotech.com

### Known Issues

- Error responses are more specific than what is shown throughout the documentation.  A 4xx or 5xx error will be returned
in all error cases.  Only a `200` status indicates success.  See a given error response for additional details.

## Installation & Usage

### Requirements.

Download Matlab environment via [Download Matlab](https://www.mathworks.com/downloads/).

### Cloning the Repo

Clone the following repo from GitHub via [Matlab Repo](https://github.com/sedaro/sedaro-matlab/tree/main/%2Bsedaro) and you can used it to interact with Sedaro API from your Matlab environment.


## Getting Started

After following the [installation procedure](#installation--usage) instruction:



Navigate to your `'sedaro-matlab/+sedaro'` directory, where you will find the following files:

* `'externals.m'`: A file that contains the main example demonstrating how to interact with the Sedaro API as well as function definitions.

* `'deserialize.m'`: A file that contains the implementation of the deserialization process.

* `'serialize.m'`: A file that contains the implementation of the serialization process.

* `'is_struct_array.m'`: A file that contains a function that checks if a variable is a struct array.

* `'test_serdes.m'`: A file that tests multiple input values to serialize/ deserialize.

* `'Secrets.m'`: A file that is used to retrieve the host URL, API key, branch IDs, workspace ID, or any other secrets from `'config.properties'`.

* `'config.properties'`: A file that contains key-value pairs of the secrets used to access the API. You need to retrieve these credentials from the Sedaro website [Home Page](https://satellite.sedaro.com) and assign them to the corresponding key in this file.



Example: (Please follow the same format, leaving a space before and after the equal sign)

    URL = https://api.sedaro.com

    API_KEY = ABCD

    WORKSPACE_ID = EFG

    SUPER_SAT_SCEN_ID = HIJ

You can now navigate to your `'sedaro-matlab/+sedaro'` open your `'externals.m'` and run the examples usage implemented in it.
