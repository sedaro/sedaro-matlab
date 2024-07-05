# Sedaro MATLAB Cosimulation Client

`sedaro-matlab` is a simple client for [cosimulating](https://sedaro.github.io/openapi/#tag/Externals) with Sedaro from the MATLAB programming language.

Read more about Sedaro at [docs.sedaro.com](https://docs.sedaro.com).

### API Key

You will need an API key to access the Sedaro platform.  You can generate an API key for your account in the Sedaro [Management Console](https://satellite.sedaro.com/account). Once generated, you'll pass the API key to all client functions.

*API keys grant full access to your account and should never be shared. If you think your API key has been compromised, you can revoke it in the [Management Console](https://satellite.sedaro.com/account).*

### Community, Support, Discussion

If you have any issues or suggestions, please reach out:

1. Join the Sedaro Community [Slack](https://join.slack.com/t/sedaro-community/shared_invite/zt-1jps4i711-mXy88AZQ9AV7YcEXr8x7Ow)
2. Email us at support@sedarotech.com

### Known Issues

- Error responses are more specific than what is shown throughout the documentation.  A 4xx or 5xx error will be returned in all error cases.  Only a `200` status indicates success.  See a given error response for additional details.

## Installation & Usage

### Cloning the Repo

To get started, clone this repository into a location that is accessible from your MATLAB IDE.

### Using `sedaro`

Within the `'+sedaro'` directory you will find the following files:

* `'externals.m'`: A file that contains the main example demonstrating how to interact with the Sedaro API via a simple cosimulation example.
* `'deserialize.m'`: Function for deserializing cosimulator responses from Sedaro into MATLAB.
* `'serialize.m'`: Function for serializing cosimulator requests from MATLAB into Sedaro.
* `'test_serdes.m'`: `serialize`/`deserialize` unit tests.
* `'config.properties'`: A file that contains key-value pairs of the secrets/credentials and other parameters that are used to access the Sedaro API. You can retrieve these credentials from the Sedaro platform [here](https://satellite.sedaro.com).


Example: (Please follow the same format, leaving a space before and after the equal sign)

    URL = https://api.sedaro.com

    API_KEY = ABCD

    WORKSPACE_ID = EFG

    SUPER_SAT_SCEN_ID = HIJ

## Running the Example

Navigate to the `'+sedaro'` directory in your MATLAB IDE and run `'externals.m'`.
