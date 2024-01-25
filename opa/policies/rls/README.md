# Rego Package for Row Level Security

This repository contains a Rego package that handles row level security (RLS) for your application.

## Overview

Row level security is a mechanism that allows you to control access to individual rows in a database or any other data source. With this Rego package, you can define fine-grained access policies that determine which rows a user can access based on their role, permissions, or any other criteria.

## Installation

To use this Rego package, follow these steps:

1. Clone this repository to your local machine.
2. Copy the `rls.rego` file from the `policies/rls` directory to your project's Rego policy directory.
3. Import the `rls` package in your main Rego policy file.

## Usage

To define row level security policies, you need to modify the `rls.rego` file. This file contains a set of rules that determine which rows are accessible to different users.

Here's an example of how you can define a simple row level security policy:

The following rule will block any user that isn't admin from viewing rows where nation key is 2

rls.rego:

```
rowFilters := {"expression": "nationkey <> 2"} if {
    not is_admin
}
```
main.rego:
```
rowFilters contains row_filter if {
    row_filter := rls.filter
}
```
