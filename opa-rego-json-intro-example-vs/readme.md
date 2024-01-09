### Background 
This repo walks through how to spin up the Open Policy Agent (OPA) service via Docker container on your local machine, then how to define a rule in rego, and use it to scan a json file to make sure it complies with the rule that you wrote. 

### Steps
* run `docker-compose up --build` - you should see the service running at localhost:8181
* run `curl -X PUT --data-binary @access_policy.rego http://localhost:8181/v1/policies/main` to give the OPA service the rule you defined - it will return {} (empty object) if there are no errors
* run `curl http://localhost:8181/v1/policies` to confirm that your policy (rego) is within the list of policies that OPA now has
* run `curl -X POST --data-binary @input.json 'http://localhost:8181/v1/data/example/allow_access' -H 'Content-Type: application/json'` to have OPA scan the contents of the `input.json` file to make sure it complies with the policies you've defined - should see a response like {"result":false/true}
* run `docker-compose down` when you are finished with OPA service locally