# Policies

This folder contains all the rego files for the access control policies. Each package has its own subfolder with the same name as the rego package. The main rego file, located in the main folder, is responsible for utilizing all the other packages.

## Structure

- `main.rego`: The main rego file that integrates all the packages and defines the overall access control logic.
- `<package_name>`: Subfolders for each package, named after the respective rego package.
  - `<package_name>.rego`: The rego file for the specific package, containing the rules and policies for that package.

## Example: Admin Package

To illustrate the structure, let's consider the example of the `admin` package. The `admin` package is responsible for granting access to admin users.

- Folder: `admin`
- Rego File: `admin.rego`
- Rule: `allow_admin`

In the `admin.rego` file, we define the `allow_admin` rule that specifies the conditions for granting access to admin users. This rule will be used in the main rego file to allow access for admin users.

Please note that this is just an example, and you can create additional packages and rules based on your specific access control requirements.